import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class CheckoutRepository {
  CheckoutRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions =
      FirebaseFunctions.instanceFor(region: 'us-central1');

  

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
  // SECURE CHECKOUT
  // ============================================================

  Future<String> createSecureOrder({
    required Map<String, dynamic> shippingAddress,
    required Map<String, dynamic> billingAddress,
    required String paymentMethod,
    required List<CartItemModel> items,
    String? couponCode,
  }) async {
    if (items.isEmpty) {
      throw Exception('Your cart is empty.');
    }

    final callable =
        _functions.httpsCallable('createSecureOrder');

    final result = await callable.call({
      'shippingAddress': shippingAddress,
      'billingAddress': billingAddress,
      'paymentMethod': paymentMethod,
      'couponCode': couponCode,
      'items': items.map((item) {
        return {
          'productId': item.productId,
          'sku': item.sku,
          'size': item.size,
          'color': item.color,
          'quantity': item.quantity,
        };
      }).toList(),
    });

    final data =
        Map<String, dynamic>.from(result.data as Map);

    final orderId =
        data['orderId']?.toString();

    if (orderId == null || orderId.isEmpty) {
      throw Exception(
        'Order was created but no order ID was returned.',
      );
    }

    return orderId;
  }

  

  // ============================================================
  // CLEAR CART
  // ============================================================

  Future<void> clearCart() async {
    await CartRepository.clearCart();
  }
}
