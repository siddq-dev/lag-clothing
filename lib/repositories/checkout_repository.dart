import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/address_model.dart';
import '../models/cart_item_model.dart';
import '../repositories/address_repository.dart';
import '../repositories/cart_repository.dart';

class CheckoutRepository {
  CheckoutRepository();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  //----------------------------------------------------------
  // Current User
  //----------------------------------------------------------

  String get _uid =>
      _auth.currentUser!.uid;

  //----------------------------------------------------------
  // Load Default Address
  //----------------------------------------------------------

Future<AddressModel?> getDefaultAddress() async {
  return AddressRepository.getDefaultShippingAddress();
}

Future<AddressModel?> getBillingAddress() async {
  return AddressRepository.getDefaultBillingAddress();
}

  //----------------------------------------------------------
  // Load Cart
  //----------------------------------------------------------

  Future<List<CartItemModel>> getCartItems() async {
    return CartRepository.getCartItems();
  }

  //----------------------------------------------------------
  // Validate Inventory
  //----------------------------------------------------------

  Future<bool> validateInventory(
    List<CartItemModel> items,
  ) async {
    for (final item in items) {
      final doc = await _firestore
          .collection("products")
          .doc(item.productId)
          .get();

      if (!doc.exists) {
        return false;
      }

      final stock =
          (doc["stock"] ?? 0) as int;

      if (stock < item.quantity) {
        return false;
      }
    }

    return true;
  }

  //----------------------------------------------------------
  // Validate Prices
  //----------------------------------------------------------

  Future<bool> validatePrices(
    List<CartItemModel> items,
  ) async {
    for (final item in items) {
      final doc = await _firestore
          .collection("products")
          .doc(item.productId)
          .get();

      if (!doc.exists) {
        return false;
      }

      final latestPrice =
          (doc["price"] as num).toDouble();

      if (latestPrice != item.price) {
        return false;
      }
    }

    return true;
  }

  //----------------------------------------------------------
  // Generate Order Number
  //----------------------------------------------------------

  String generateOrderNumber() {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch;

    return "LAG$timestamp";
  }

  //----------------------------------------------------------
  // Generate Tracking ID
  //----------------------------------------------------------

  String generateTrackingId() {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch;

    return "TRK$timestamp";
  }

  //----------------------------------------------------------
  // Create Order
  //----------------------------------------------------------

  Future<String> createOrder({
    required Map<String, dynamic> orderData,
  }) async {
    final doc =
        _firestore.collection("orders").doc();

    await doc.set(orderData);

    return doc.id;
  }

  //----------------------------------------------------------
  // Update Inventory
  //----------------------------------------------------------

  Future<void> updateInventory(
    List<CartItemModel> items,
  ) async {
    final batch =
        _firestore.batch();

    for (final item in items) {
      final ref = _firestore
          .collection("products")
          .doc(item.productId);

      final snap = await ref.get();

      final stock =
          (snap["stock"] ?? 0) as int;

      batch.update(ref, {
        "stock": stock - item.quantity,
      });
    }

    await batch.commit();
  }

  //----------------------------------------------------------
  // Clear Cart
  //----------------------------------------------------------

  Future<void> clearCart() async {
    await CartRepository.clearCart();
  }
}