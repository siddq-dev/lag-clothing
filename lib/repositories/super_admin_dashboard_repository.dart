import 'package:cloud_firestore/cloud_firestore.dart';

class SuperAdminDashboardRepository {
  SuperAdminDashboardRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============================================================
  // DASHBOARD STATISTICS
  // ============================================================

  static Future<Map<String, int>> getDashboardStatistics() async {
    // ------------------------------------------------------------
    // Fetch all required collections in parallel
    // ------------------------------------------------------------

    final results = await Future.wait([
      _getAdminCount(),
      _getProductCount(),
      _getCustomerCount(),
      _getOrderCount(),
    ]);

    return {
      'admins': results[0],
      'products': results[1],
      'customers': results[2],
      'orders': results[3],
    };
  }

  // ============================================================
  // ADMINS
  // ============================================================

  static Future<int> _getAdminCount() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .get();

    return snapshot.docs.length;
  }

  // ============================================================
  // PRODUCTS
  // ============================================================

  static Future<int> _getProductCount() async {
    final snapshot = await _firestore.collection('products').get();

    return snapshot.docs.length;
  }

  // ============================================================
  // CUSTOMERS
  // ============================================================

  static Future<int> _getCustomerCount() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .get();

    return snapshot.docs.length;
  }

  // ============================================================
  // ORDERS
  // ============================================================

  static Future<int> _getOrderCount() async {
    final snapshot = await _firestore.collection('orders').get();

    return snapshot.docs.length;
  }
}
