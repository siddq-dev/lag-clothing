import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class CheckoutRepository {
  CheckoutRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ============================================================
  // CURRENT USER
  // ============================================================

  String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in.');
    }

    return user.uid;
  }

  // ============================================================
  // CART
  // ============================================================

  Future<List<CartItemModel>> getCartItems() async {
    return CartRepository.getCartItems();
  }

  // ============================================================
  // INVENTORY VALIDATION
  // ============================================================

  Future<bool> validateInventory(List<CartItemModel> items) async {
    if (items.isEmpty) {
      return false;
    }

    for (final item in items) {
      final productReference = _firestore
          .collection('products')
          .doc(item.productId);

      final snapshot = await productReference.get();

      if (!snapshot.exists) {
        return false;
      }

      final data = snapshot.data();

      if (data == null) {
        return false;
      }

      final stock = (data['stock'] as num?)?.toInt() ?? 0;

      if (stock < item.quantity) {
        return false;
      }

      // ----------------------------------------------------------
      // VALIDATE PRODUCT VARIANT
      // ----------------------------------------------------------

      final variants = data['variants'];

      if (variants is List) {
        final matchingVariant = variants.cast<dynamic>().firstWhere((variant) {
          if (variant is! Map) {
            return false;
          }

          final variantSku = (variant['sku'] ?? '').toString().trim();

          final itemSku = item.sku.trim();

          return variantSku == itemSku;
        }, orElse: () => null);

        if (matchingVariant == null) {
          return false;
        }

        final variantStock = (matchingVariant['stock'] as num?)?.toInt() ?? 0;

        if (variantStock < item.quantity) {
          return false;
        }
      }
    }

    return true;
  }

  // ============================================================
  // PRICE VALIDATION
  // ============================================================

  Future<bool> validatePrices(List<CartItemModel> items) async {
    if (items.isEmpty) {
      return false;
    }

    for (final item in items) {
      final productReference = _firestore
          .collection('products')
          .doc(item.productId);

      final snapshot = await productReference.get();

      if (!snapshot.exists) {
        return false;
      }

      final data = snapshot.data();

      if (data == null) {
        return false;
      }

      final regularPrice = (data['price'] as num?)?.toDouble();

      if (regularPrice == null) {
        return false;
      }

      // A product on sale is added to the cart at its sale price,
      // not its regular price.
      final salePrice = (data['salePrice'] as num?)?.toDouble();

      final effectivePrice = (salePrice != null && salePrice > 0)
          ? salePrice
          : regularPrice;

      if ((effectivePrice - item.price).abs() > 0.001) {
        return false;
      }
    }

    return true;
  }

  // ============================================================
  // ORDER NUMBER
  // ============================================================

  String generateOrderNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    return 'LAG$timestamp';
  }

  // ============================================================
  // TRACKING ID
  // ============================================================

  String generateTrackingId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    return 'TRK$timestamp';
  }

  // ============================================================
  // CREATE ORDER + UPDATE PRODUCT + UPDATE VARIANT
  // ============================================================

  Future<String> createOrder({
    required Map<String, dynamic> orderData,
    required List<CartItemModel> items,
  }) async {
    final userId = _uid;

    final orderReference = _firestore.collection('orders').doc();

    final orderDataToWrite = Map<String, dynamic>.from(orderData);

    orderDataToWrite['userId'] = userId;

    orderDataToWrite['createdAt'] = FieldValue.serverTimestamp();

    orderDataToWrite['updatedAt'] = FieldValue.serverTimestamp();

    // ----------------------------------------------------------
    // FIRESTORE TRANSACTION
    // ----------------------------------------------------------

    final failureReason = await _firestore.runTransaction<String?>((
      transaction,
    ) async {
      // ======================================================
      // STORE PRODUCT SNAPSHOTS
      // ======================================================

      final productSnapshots =
          <DocumentReference, DocumentSnapshot<Map<String, dynamic>>>{};

      // ======================================================
      // READ ALL PRODUCTS FIRST
      // ======================================================

      for (final item in items) {
        final productReference = _firestore
            .collection('products')
            .doc(item.productId);

        final snapshot = await transaction.get(productReference);

        productSnapshots[productReference] = snapshot;
      }

      // ======================================================
      // VALIDATE ALL PRODUCTS
      // ======================================================

      for (final item in items) {
        final productReference = _firestore
            .collection('products')
            .doc(item.productId);

        final snapshot = productSnapshots[productReference];

        if (snapshot == null || !snapshot.exists) {
          return 'Product ${item.productName} no longer exists.';
        }

        final data = snapshot.data();

        if (data == null) {
          return 'Unable to read product ${item.productName}.';
        }

        // ====================================================
        // PRODUCT STOCK
        // ====================================================

        final productStock = (data['stock'] as num?)?.toInt() ?? 0;

        if (productStock < item.quantity) {
          return 'Insufficient stock for ${item.productName}.';
        }

        // ====================================================
        // PRICE VALIDATION
        // ====================================================

        final regularPrice = (data['price'] as num?)?.toDouble();

        if (regularPrice == null) {
          return 'Unable to verify price for ${item.productName}.';
        }

        final salePrice = (data['salePrice'] as num?)?.toDouble();

        final effectivePrice = (salePrice != null && salePrice > 0)
            ? salePrice
            : regularPrice;

        if ((effectivePrice - item.price).abs() > 0.001) {
          return 'Price changed for ${item.productName}.';
        }

        // ====================================================
        // PRODUCT VARIANT VALIDATION
        // ====================================================

        final variants = data['variants'];

        if (variants is List) {
          Map<String, dynamic>? matchingVariant;

          for (final rawVariant in variants) {
            if (rawVariant is! Map) {
              continue;
            }

            final variant = Map<String, dynamic>.from(rawVariant);

            final variantSku = (variant['sku'] ?? '').toString().trim();

            final itemSku = item.sku.trim();

            if (variantSku == itemSku) {
              matchingVariant = variant;
              break;
            }
          }

          if (matchingVariant == null) {
            return 'Variant ${item.color} / ${item.size} '
                'for ${item.productName} no longer exists.';
          }

          // ==================================================
          // VARIANT STOCK
          // ==================================================

          final variantStock = (matchingVariant['stock'] as num?)?.toInt() ?? 0;

          if (variantStock < item.quantity) {
            return 'Insufficient stock for '
                '${item.productName} '
                '(${item.color} / ${item.size}).';
          }
        }
      }

      // ======================================================
      // UPDATE PRODUCTS + VARIANTS
      // ======================================================

      for (final item in items) {
        final productReference = _firestore
            .collection('products')
            .doc(item.productId);

        final snapshot = productSnapshots[productReference]!;

        final data = snapshot.data()!;

        // ----------------------------------------------------
        // CURRENT PRODUCT STOCK
        // ----------------------------------------------------

        final currentProductStock = (data['stock'] as num?)?.toInt() ?? 0;

        // ----------------------------------------------------
        // UPDATE VARIANTS ARRAY
        // ----------------------------------------------------

        final variants = data['variants'];

        List<dynamic>? updatedVariants;

        if (variants is List) {
          updatedVariants = variants.map((rawVariant) {
            if (rawVariant is! Map) {
              return rawVariant;
            }

            final variant = Map<String, dynamic>.from(rawVariant);

            final variantSku = (variant['sku'] ?? '').toString().trim();

            final itemSku = item.sku.trim();

            // ------------------------------------------------
            // MATCH:
            //
            // productId = document ID
            // sku       = cart item SKU
            // ------------------------------------------------

            if (variantSku == itemSku) {
              final currentVariantStock =
                  (variant['stock'] as num?)?.toInt() ?? 0;

              final newVariantStock = currentVariantStock - item.quantity;

              variant['stock'] = newVariantStock;

              // Keep 'available' consistent with the new stock,
              // same rule already used by the admin form
              // (stock > 0 => available). Without this, a
              // variant that just sold out would still read as
              // available until someone manually re-saved it.
              variant['available'] = newVariantStock > 0;
            }

            return variant;
          }).toList();
        }

        // ----------------------------------------------------
        // UPDATE PRODUCT DOCUMENT
        // ----------------------------------------------------

        final updateData = <String, dynamic>{
          // Parent product inventory.
          'stock': currentProductStock - item.quantity,

          'updatedAt': FieldValue.serverTimestamp(),
        };

        // Only update variants when the product actually
        // contains a variants array.
        if (updatedVariants != null) {
          updateData['variants'] = updatedVariants;
        }

        transaction.update(productReference, updateData);
      }

      // ======================================================
      // CREATE ORDER
      // ======================================================

      transaction.set(orderReference, orderDataToWrite);

      return null;
    });

    // ==========================================================
    // HANDLE TRANSACTION FAILURE
    // ==========================================================

    if (failureReason != null) {
      throw Exception(failureReason);
    }

    return orderReference.id;
  }

  // ============================================================
  // CLEAR CART
  // ============================================================

  Future<void> clearCart() async {
    await CartRepository.clearCart();
  }
}
