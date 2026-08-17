import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/analytics_summary_model.dart';
import '../models/customer_region_model.dart';
import '../models/device_analytics_model.dart';
import '../models/inventory_analytics_model.dart';
import '../models/page_analytics_model.dart';
import '../models/sales_chart_model.dart';
import '../models/traffic_source_model.dart';

class AnalyticsRepository {
  AnalyticsRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //----------------------------------------------------------
  // Dashboard Summary
  //----------------------------------------------------------

  static Future<AnalyticsSummaryModel> getSummary() async {
    final ordersSnapshot = await _firestore.collection('orders').get();

    final usersSnapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .get();

    final productsSnapshot = await _firestore.collection('products').get();

    double revenue = 0;

    for (final doc in ordersSnapshot.docs) {
      revenue += (doc['total'] ?? 0).toDouble();
    }

    final double averageOrder = ordersSnapshot.docs.isEmpty
        ? 0
        : revenue / ordersSnapshot.docs.length;

    return AnalyticsSummaryModel(
      totalRevenue: revenue,
      totalOrders: ordersSnapshot.docs.length,
      totalCustomers: usersSnapshot.docs.length,
      totalProducts: productsSnapshot.docs.length,
      averageOrderValue: averageOrder,
      todayVisitors: 0,
      totalVisitors: 0,
    );
  }

  //----------------------------------------------------------
  // Sales Chart
  //----------------------------------------------------------

  static Future<List<SalesChartModel>> getSalesChart() async {
    final snapshot = await _firestore
        .collection('orders')
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs.map((doc) {
      return SalesChartModel(
        date: doc['createdAt'] ?? Timestamp.now(),
        revenue: (doc['total'] ?? 0).toDouble(),
        orders: 1,
      );
    }).toList();
  }

  //----------------------------------------------------------
  // Page Analytics
  //----------------------------------------------------------

  static Future<List<PageAnalyticsModel>> getPageAnalytics() async {
    final snapshot = await _firestore.collection('page_visits').get();

    final Map<String, int> pageViews = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final page = (data['page'] as String?) ?? "Unknown";

      pageViews[page] = (pageViews[page] ?? 0) + 1;
    }

    return pageViews.entries
        .map(
          (e) => PageAnalyticsModel(
            page: e.key,
            views: e.value,
            uniqueVisitors: e.value,
            averageTime: 0,
          ),
        )
        .toList();
  }

  //----------------------------------------------------------
  // Customer Region
  //----------------------------------------------------------

  static Future<List<CustomerRegionModel>> getCustomerRegions() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'customer')
        .get();

    final Map<String, int> countries = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final country = (data['country'] as String?) ?? "Unknown";

      countries[country] = (countries[country] ?? 0) + 1;
    }

    return countries.entries
        .map(
          (e) => CustomerRegionModel(
            country: e.key,
            customers: e.value,
            orders: 0,
            revenue: 0,
          ),
        )
        .toList();
  }

  //----------------------------------------------------------
  // Device Analytics
  //----------------------------------------------------------

  static Future<List<DeviceAnalyticsModel>> getDeviceAnalytics() async {
    final snapshot = await _firestore.collection('page_visits').get();

    final Map<String, int> devices = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final device = (data['device'] as String?) ?? "Unknown";

      devices[device] = (devices[device] ?? 0) + 1;
    }

    final total = snapshot.docs.length;

    return devices.entries
        .map(
          (e) => DeviceAnalyticsModel(
            device: e.key,
            visitors: e.value,
            percentage: total == 0 ? 0 : (e.value / total) * 100,
          ),
        )
        .toList();
  }

  //----------------------------------------------------------
  // Traffic Sources
  //----------------------------------------------------------

  static Future<List<TrafficSourceModel>> getTrafficSources() async {
    final snapshot = await _firestore.collection('page_visits').get();

    final Map<String, int> sources = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      final source = (data['source'] as String?) ?? "Direct";

      sources[source] = (sources[source] ?? 0) + 1;
    }

    return sources.entries
        .map((e) => TrafficSourceModel(source: e.key, visitors: e.value))
        .toList();
  }

  //----------------------------------------------------------
  // Best Selling Products
  //----------------------------------------------------------

  static Future<List<Map<String, dynamic>>> getBestSellingProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .orderBy('soldCount', descending: true)
        .limit(10)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return {
        "id": doc.id,
        "name": data["name"] ?? "",
        "sold": data["soldCount"] ?? 0,
        "revenue": (data["revenue"] ?? 0).toDouble(),
        "stock": data["stock"] ?? 0,
      };
    }).toList();
  }

  // Low Stock Products
  //----------------------------------------------------------

  static Future<List<Map<String, dynamic>>> getLowStockProducts() async {
    final snapshot = await _firestore.collection("products").get();

    final List<Map<String, dynamic>> products = [];

    for (final doc in snapshot.docs) {
      final stock = doc["stock"] ?? 0;

      if (stock <= 10) {
        products.add({"id": doc.id, "name": doc["name"] ?? "", "stock": stock});
      }
    }

    return products;
  }

  //----------------------------------------------------------
  // Inventory Analytics
  //----------------------------------------------------------

  static Future<InventoryAnalyticsModel> getInventoryAnalytics() async {
    final snapshot = await _firestore.collection('products').get();

    int inStock = 0;

    int lowStock = 0;

    int outOfStock = 0;

    double inventoryValue = 0;

    for (final doc in snapshot.docs) {
      final stock = doc['stock'] ?? 0;

      final price = (doc['price'] ?? 0).toDouble();

      inventoryValue += stock * price;

      if (stock == 0) {
        outOfStock++;
      } else if (stock <= 10) {
        lowStock++;
      } else {
        inStock++;
      }
    }

    return InventoryAnalyticsModel(
      totalProducts: snapshot.docs.length,
      inStock: inStock,
      lowStock: lowStock,
      outOfStock: outOfStock,
      inventoryValue: inventoryValue,
    );
  }
}
