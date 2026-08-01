import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_item_model.dart';

class CartRepository {
  CartRepository._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static String get _uid =>
      _auth.currentUser!.uid;

  static CollectionReference<Map<String, dynamic>>
      get _cartCollection => _firestore
          .collection('cart')
          .doc(_uid)
          .collection('items');

  //==================================================
  // Add Item
  //==================================================

  static Future<void> addToCart(
    CartItemModel item,
  ) async {
    final doc = _cartCollection.doc(item.productId);

    final snapshot = await doc.get();

    if (snapshot.exists) {
      final data = snapshot.data()!;

      final quantity =
          (data['quantity'] ?? 1) + item.quantity;

      await doc.update({
        'quantity': quantity,
      });
    } else {
      await doc.set(
        item
            .copyWith(
              id: item.productId,
              addedAt: Timestamp.now(),
            )
            .toMap(),
      );
    }
  }

  //==================================================
  // Fetch Cart
  //==================================================

  static Future<List<CartItemModel>>
      getCartItems() async {
    final snapshot = await _cartCollection.get();

    return snapshot.docs
        .map(
          (doc) => CartItemModel.fromMap(
            doc.id,
            doc.data(),
          ),
        )
        .toList();
  }

  //==================================================
  // Stream Cart
  //==================================================

  static Stream<List<CartItemModel>>
      streamCart() {
    return _cartCollection
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    CartItemModel.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  //==================================================
  // Update Quantity
  //==================================================

  static Future<void> updateQuantity(
    String productId,
    int quantity,
  ) async {
    if (quantity <= 0) {
      await removeItem(productId);
      return;
    }

    await _cartCollection.doc(productId).update({
      'quantity': quantity,
    });
  }

  //==================================================
  // Remove Item
  //==================================================

  static Future<void> removeItem(
    String productId,
  ) async {
    await _cartCollection.doc(productId).delete();
  }

  //==================================================
  // Clear Cart
  //==================================================

  static Future<void> clearCart() async {
    final snapshot = await _cartCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}