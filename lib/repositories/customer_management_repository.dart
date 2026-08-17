import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/order_model.dart';

import '../models/customer_admin_model.dart';

class CustomerManagementRepository {
  CustomerManagementRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //----------------------------------------------------------
  // Customers
  //----------------------------------------------------------

  static Future<List<CustomerAdminModel>> getCustomers() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => CustomerAdminModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  //----------------------------------------------------------
  // Stream Customers
  //----------------------------------------------------------

  static Stream<List<CustomerAdminModel>> streamCustomers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CustomerAdminModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  //----------------------------------------------------------
  // Orders
  //----------------------------------------------------------

  static Future<List<OrderModel>> getCustomerOrders(String uid) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('orderedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
  }

  //----------------------------------------------------------
  // Current Active Order
  //----------------------------------------------------------

  static Future<OrderModel?> getCurrentOrder(String uid) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .where(
          'status',
          whereIn: [
            'pending',
            'confirmed',
            'processing',
            'packed',
            'shipped',
            'outForDelivery',
          ],
        )
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return OrderModel.fromMap(snapshot.docs.first.data());
  }
}
