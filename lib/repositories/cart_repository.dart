import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_item_model.dart';

class CartRepository {
  CartRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ============================================================
  // CURRENT USER
  // ============================================================

  static User get _currentUser {
    final user = _auth.currentUser;

    if (user == null) {
      throw StateError('Please login to use the cart.');
    }

    return user;
  }

  static String get _uid => _currentUser.uid;

  // ============================================================
  // CART COLLECTION
  //
  // cart
  //   └── USER_UID
  //       └── items
  //           ├── product__m__black
  //           ├── product__l__black
  //           └── product__m__white
  //
  // Each size + color combination is a separate cart item.
  // ============================================================

  static CollectionReference<Map<String, dynamic>> get _cartCollection {
    return _firestore.collection('cart').doc(_uid).collection('items');
  }

  // ============================================================
  // CREATE VARIANT DOCUMENT ID
  // ============================================================

  static String _variantId({
    required String productId,
    required String size,
    required String color,
  }) {
    final normalizedProduct = productId.trim();

    final normalizedSize = size.trim().toLowerCase();

    final normalizedColor = color.trim().toLowerCase();

    final raw = '${normalizedProduct}__${normalizedSize}__${normalizedColor}';

    return raw
        .replaceAll('/', '_')
        .replaceAll('\\', '_')
        .replaceAll('#', '_')
        .replaceAll('[', '_')
        .replaceAll(']', '_')
        .replaceAll('.', '_')
        .replaceAll(' ', '_');
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  static Future<void> addToCart(CartItemModel item) async {
    // ----------------------------------------------------------
    // VALIDATION
    // ----------------------------------------------------------

    if (item.productId.trim().isEmpty) {
      throw StateError('Invalid product.');
    }

    if (item.size.trim().isEmpty) {
      throw StateError('Please select a size.');
    }

    if (item.color.trim().isEmpty) {
      throw StateError('Please select a color.');
    }

    if (item.quantity <= 0) {
      throw StateError('Quantity must be greater than zero.');
    }

    if (!item.isAvailable) {
      throw StateError('Selected variant is unavailable.');
    }

    if (item.availableStock != null && item.quantity > item.availableStock!) {
      throw StateError(
        'Only ${item.availableStock} item(s) are available for the selected variant.',
      );
    }

    // ----------------------------------------------------------
    // EXACT VARIANT ID
    // ----------------------------------------------------------

    final size = item.size.trim();
    final color = item.color.trim();

    final documentId = _variantId(
      productId: item.productId,
      size: size,
      color: color,
    );

    final doc = _cartCollection.doc(documentId);

    // ----------------------------------------------------------
    // TRANSACTION
    // ----------------------------------------------------------

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(doc);

      if (snapshot.exists) {
        final data = snapshot.data() ?? {};

        final existingQuantity = (data['quantity'] as num?)?.toInt() ?? 0;

        final newQuantity = existingQuantity + item.quantity;

        // ----------------------------------------------------
        // CHECK STOCK FOR COMBINED QUANTITY
        // ----------------------------------------------------

        if (item.availableStock != null && newQuantity > item.availableStock!) {
          throw StateError(
            'Only ${item.availableStock} item(s) are available for this variant. '
            'You already have $existingQuantity in your cart.',
          );
        }

        transaction.update(doc, {
          'productId': item.productId,
          'productName': item.productName,
          'productImage': item.productImage,
          'price': item.price,
          'quantity': newQuantity,
          'size': size,
          'color': color,
          'sku': item.sku,
          'availableStock': item.availableStock,
          'isAvailable': item.isAvailable,
        });
      } else {
        transaction.set(doc, {
          'productId': item.productId,
          'productName': item.productName,
          'productImage': item.productImage,
          'price': item.price,
          'quantity': item.quantity,
          'size': size,
          'color': color,
          'sku': item.sku,
          'availableStock': item.availableStock,
          'isAvailable': item.isAvailable,
          'addedAt': Timestamp.now(),
        });
      }
    });
  }

  // ============================================================
  // GET CART
  // ============================================================

  static Future<List<CartItemModel>> getCartItems() async {
    final snapshot = await _cartCollection.get();

    return snapshot.docs.map((doc) {
      return CartItemModel.fromMap(doc.id, doc.data());
    }).toList();
  }

  // ============================================================
  // STREAM CART
  // ============================================================

  static Stream<List<CartItemModel>> streamCart() {
    return _cartCollection.orderBy('addedAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return CartItemModel.fromMap(doc.id, doc.data());
        }).toList();
      },
    );
  }

  // ============================================================
  // UPDATE QUANTITY
  // ============================================================

  static Future<void> updateQuantity(String itemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(itemId);
      return;
    }

    final doc = _cartCollection.doc(itemId);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      throw StateError('Cart item no longer exists.');
    }

    final data = snapshot.data() ?? {};

    final isAvailable = data['isAvailable'] is bool
        ? data['isAvailable'] as bool
        : true;

    final availableStock = (data['availableStock'] as num?)?.toInt();

    if (!isAvailable) {
      throw StateError('This product variant is no longer available.');
    }

    if (availableStock != null && quantity > availableStock) {
      throw StateError(
        'Only $availableStock item(s) are available for this variant.',
      );
    }

    await doc.update({'quantity': quantity});
  }

  // ============================================================
  // REMOVE ITEM
  // ============================================================

  static Future<void> removeItem(String itemId) async {
    await _cartCollection.doc(itemId).delete();
  }

  // ============================================================
  // CLEAR CART
  // ============================================================

  static Future<void> clearCart() async {
    final snapshot = await _cartCollection.get();

    if (snapshot.docs.isEmpty) {
      return;
    }

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
