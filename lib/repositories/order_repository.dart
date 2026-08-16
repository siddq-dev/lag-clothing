import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/stock_update_service.dart';
import '../models/order_model.dart';

class OrderRepository {
  OrderRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ============================================================
  // CURRENT USER
  // ============================================================

  static String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return user.uid;
  }

  // ============================================================
  // ORDERS COLLECTION
  // ============================================================

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('orders');

  // ============================================================
  // CREATE ORDER
  // ============================================================

  static Future<void> createOrder(OrderModel order) async {
    final orderDoc = _collection.doc();

    final newOrder = order.copyWith(
      id: orderDoc.id,
      userId: _uid,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    final List<Map<String, dynamic>> stockLogs = [];

    await _firestore.runTransaction((transaction) async {
      // ------------------------------------------------------
      // CREATE ORDER
      // ------------------------------------------------------

      transaction.set(orderDoc, newOrder.toMap());

      // ------------------------------------------------------
      // UPDATE INVENTORY
      // ------------------------------------------------------

      for (final item in newOrder.items) {
        final productRef = _firestore
            .collection('products')
            .doc(item.productId);

        final productSnapshot = await transaction.get(productRef);

        if (!productSnapshot.exists) {
          throw Exception(
            'Product not found: '
            '${item.productName}',
          );
        }

        final data = productSnapshot.data();

        if (data == null) {
          throw Exception(
            'Unable to read product: '
            '${item.productName}',
          );
        }

        final int currentStock = (data['stock'] as num?)?.toInt() ?? 0;

        if (currentStock < item.quantity) {
          throw Exception('${item.productName} is out of stock.');
        }

        final int newStock = currentStock - item.quantity;

        final double price = (data['price'] as num?)?.toDouble() ?? 0;

        transaction.update(productRef, {
          'stock': newStock,

          'soldCount': FieldValue.increment(item.quantity),

          'revenue': FieldValue.increment(item.quantity * price),

          'updatedAt': Timestamp.now(),
        });

        stockLogs.add({
          'productId': item.productId,

          'productName': item.productName,

          'quantity': item.quantity,

          'previousStock': currentStock,

          'newStock': newStock,
        });
      }
    });

    // ----------------------------------------------------------
    // STOCK LOGS
    // ----------------------------------------------------------

    for (final log in stockLogs) {
      await StockUpdateService.logStockOut(
        productId: log['productId'],

        productName: log['productName'],

        quantity: log['quantity'],

        previousStock: log['previousStock'],

        newStock: log['newStock'],

        reference: newOrder.orderNumber,

        performedBy: 'system',
      );
    }
  }

  // ============================================================
  // GET CUSTOMER ORDERS
  // ============================================================

  static Future<List<OrderModel>> getOrders() async {
    final snapshot = await _collection.where('userId', isEqualTo: _uid).get();

    final orders = snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());

      // ------------------------------------------------
      // Some older documents may not have their
      // Firestore document ID inside the "id" field.
      // Use the document ID as a fallback.
      // ------------------------------------------------

      data['id'] = data['id'] ?? doc.id;

      return OrderModel.fromMap(data);
    }).toList();

    // ----------------------------------------------------------
    // SORT LOCALLY
    //
    // This avoids requiring a composite Firestore index for:
    // where(userId) + orderBy(createdAt)
    // ----------------------------------------------------------

    orders.sort((a, b) {
      final aDate = a.createdAt?.toDate();

      final bDate = b.createdAt?.toDate();

      if (aDate == null && bDate == null) {
        return 0;
      }

      if (aDate == null) {
        return 1;
      }

      if (bDate == null) {
        return -1;
      }

      return bDate.compareTo(aDate);
    });

    return orders;
  }

  // ============================================================
  // ADMIN - GET ALL ORDERS
  // ============================================================

  static Future<List<OrderModel>> getAllOrders() async {
    final snapshot = await _collection
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());

      data['id'] = data['id'] ?? doc.id;

      return OrderModel.fromMap(data);
    }).toList();
  }

  // ============================================================
  // CUSTOMER STREAM
  // ============================================================

  static Stream<List<OrderModel>> streamOrders() {
    return _collection.where('userId', isEqualTo: _uid).snapshots().map((
      snapshot,
    ) {
      final orders = snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());

        data['id'] = data['id'] ?? doc.id;

        return OrderModel.fromMap(data);
      }).toList();

      // ------------------------------------------------
      // Sort locally for the same reason as getOrders().
      // ------------------------------------------------

      orders.sort((a, b) {
        final aDate = a.createdAt?.toDate();

        final bDate = b.createdAt?.toDate();

        if (aDate == null && bDate == null) {
          return 0;
        }

        if (aDate == null) {
          return 1;
        }

        if (bDate == null) {
          return -1;
        }

        return bDate.compareTo(aDate);
      });

      return orders;
    });
  }

  // ============================================================
  // ADMIN STREAM
  // ============================================================

  static Stream<List<OrderModel>> streamAllOrders() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());

        data['id'] = data['id'] ?? doc.id;

        return OrderModel.fromMap(data);
      }).toList();
    });
  }

  // ============================================================
  // GET SINGLE ORDER
  // ============================================================

  static Future<OrderModel?> getOrder(String orderId) async {
    final snapshot = await _collection.doc(orderId).get();

    if (!snapshot.exists) {
      return null;
    }

    final data = Map<String, dynamic>.from(snapshot.data()!);

    data['id'] = data['id'] ?? snapshot.id;

    return OrderModel.fromMap(data);
  }

  // ============================================================
  // UPDATE ORDER STATUS
  // ============================================================

  static Future<void> updateOrderStatus(
    String orderId,
    OrderStatus status,
  ) async {
    await _collection.doc(orderId).update({
      'orderStatus': status.name,

      'updatedAt': Timestamp.now(),
    });
  }

  // ============================================================
  // UPDATE PAYMENT STATUS
  // ============================================================

  static Future<void> updatePaymentStatus(
    String orderId,
    PaymentStatus status,
  ) async {
    await _collection.doc(orderId).update({
      'paymentStatus': status.name,

      'updatedAt': Timestamp.now(),
    });
  }

  // ============================================================
  // CANCEL ORDER
  // ============================================================

  static Future<void> cancelOrder(String orderId) async {
    await updateOrderStatus(orderId, OrderStatus.cancelled);
  }

  // ============================================================
  // RETURN ORDER
  // ============================================================

  static Future<void> returnOrder(String orderId) async {
    await updateOrderStatus(orderId, OrderStatus.returned);
  }

  // ============================================================
  // ADMIN NOTES
  // ============================================================

  static Future<void> updateAdminNotes(String orderId, String notes) async {
    await _collection.doc(orderId).update({
      'adminNotes': notes,

      'updatedAt': Timestamp.now(),
    });
  }

  // ============================================================
  // DELETE ORDER
  // ============================================================

  static Future<void> deleteOrder(String orderId) async {
    await _collection.doc(orderId).delete();
  }
}
