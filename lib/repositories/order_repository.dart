import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_model.dart';

class OrderRepository {
  OrderRepository._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static String get _uid =>
      _auth.currentUser!.uid;

  static CollectionReference<Map<String, dynamic>>
      get _collection =>
          _firestore.collection('orders');

  // ==========================================
  // Create Order
  // ==========================================

  static Future<void> createOrder(
    OrderModel order,
  ) async {
    final doc = _collection.doc();

    await doc.set(
      order
          .copyWith(
            id: doc.id,
            userId: _uid,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          )
          .toMap(),
    );
  }

  // ==========================================
  // Get User Orders
  // ==========================================

  static Future<List<OrderModel>> getOrders() async {
    final snapshot = await _collection
        .where('userId', isEqualTo: _uid)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (doc) => OrderModel.fromMap(
            doc.data(),
          ),
        )
        .toList();
  }

  // ==========================================
  // Stream Orders
  // ==========================================

  static Stream<List<OrderModel>> streamOrders() {
    return _collection
        .where('userId', isEqualTo: _uid)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => OrderModel.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  // ==========================================
  // Get Single Order
  // ==========================================

  static Future<OrderModel?> getOrder(
    String orderId,
  ) async {
    final snapshot =
        await _collection.doc(orderId).get();

    if (!snapshot.exists) return null;

    return OrderModel.fromMap(
      snapshot.data()!,
    );
  }

  // ==========================================
  // Update Order Status
  // ==========================================

  static Future<void> updateOrderStatus(
    String orderId,
    OrderStatus status,
  ) async {
    await _collection.doc(orderId).update({
      'orderStatus': status.name,
      'updatedAt': Timestamp.now(),
    });
  }

  // ==========================================
  // Cancel Order
  // ==========================================

  static Future<void> cancelOrder(
    String orderId,
  ) async {
    await updateOrderStatus(
      orderId,
      OrderStatus.cancelled,
    );
  }

  // ==========================================
  // Return Order
  // ==========================================

  static Future<void> returnOrder(
    String orderId,
  ) async {
    await updateOrderStatus(
      orderId,
      OrderStatus.returned,
    );
  }

  // ==========================================
  // Delete Order
  // ==========================================

  static Future<void> deleteOrder(
    String orderId,
  ) async {
    await _collection.doc(orderId).delete();
  }
}