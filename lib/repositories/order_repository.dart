import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/stock_update_service.dart';

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
  final orderDoc = _collection.doc();

  final newOrder = order.copyWith(
    id: orderDoc.id,
    userId: _uid,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  );

  // Store stock information for logging
  final List<Map<String, dynamic>> stockLogs = [];

  await _firestore.runTransaction((transaction) async {
    // Create Order
    transaction.set(
      orderDoc,
      newOrder.toMap(),
    );

    // Update Inventory
    for (final item in newOrder.items) {
      final productRef = _firestore
          .collection("products")
          .doc(item.productId);

      final productSnapshot =
          await transaction.get(productRef);

      if (!productSnapshot.exists) {
        throw Exception(
          "Product not found: ${item.productName}",
        );
      }

      final data = productSnapshot.data()!;

      final int currentStock =
          (data["stock"] ?? 0) as int;

      if (currentStock < item.quantity) {
        throw Exception(
          "${item.productName} is out of stock.",
        );
      }

      final int newStock =
          currentStock - item.quantity;

      final double price =
          (data["price"] ?? 0).toDouble();

      transaction.update(productRef, {
        "stock": newStock,
        "soldCount":
            FieldValue.increment(item.quantity),
        "revenue":
            FieldValue.increment(
          item.quantity * price,
        ),
        "updatedAt": Timestamp.now(),
      });

      // Save values for inventory logs
      stockLogs.add({
        "productId": item.productId,
        "productName": item.productName,
        "quantity": item.quantity,
        "previousStock": currentStock,
        "newStock": newStock,
      });
    }
  });

  // Write inventory logs AFTER transaction succeeds
  for (final log in stockLogs) {
    await StockUpdateService.logStockOut(
      productId: log["productId"],
      productName: log["productName"],
      quantity: log["quantity"],
      previousStock: log["previousStock"],
      newStock: log["newStock"],
      reference: newOrder.orderNumber,
      performedBy: "system",
    );
  }
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
// Admin - Get All Orders
// ==========================================

static Future<List<OrderModel>> getAllOrders() async {
  final snapshot = await _collection
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
// Admin Stream
// ==========================================

static Stream<List<OrderModel>> streamAllOrders() {
  return _collection
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
// Update Payment Status
// ==========================================

static Future<void> updatePaymentStatus(
  String orderId,
  PaymentStatus status,
) async {
  await _collection.doc(orderId).update({
    'paymentStatus': status.name,
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


static Future<void> updateAdminNotes(
  String orderId,
  String notes,
) async {
  await _collection.doc(orderId).update({
    'adminNotes': notes,
    'updatedAt': Timestamp.now(),
  });
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