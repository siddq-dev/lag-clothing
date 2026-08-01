import 'package:flutter/material.dart';

import '../models/analytics_summary_model.dart';
import '../models/customer_region_model.dart';
import '../models/device_analytics_model.dart';
import '../models/inventory_analytics_model.dart';
import '../models/page_analytics_model.dart';
import '../models/sales_chart_model.dart';
import '../models/traffic_source_model.dart';

import '../repositories/analytics_repository.dart';

class AnalyticsProvider extends ChangeNotifier {
  //----------------------------------------------------------
  // Loading
  //----------------------------------------------------------

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //----------------------------------------------------------
  // Error
  //----------------------------------------------------------

  String? _error;

  String? get error => _error;

  //----------------------------------------------------------
  // Summary
  //----------------------------------------------------------

  AnalyticsSummaryModel? _summary;

  AnalyticsSummaryModel? get summary => _summary;

  //----------------------------------------------------------
  // Sales Chart
  //----------------------------------------------------------

  List<SalesChartModel> _salesChart = [];

  List<SalesChartModel> get salesChart =>
      _salesChart;

  //----------------------------------------------------------
  // Page Analytics
  //----------------------------------------------------------

  List<PageAnalyticsModel> _pages = [];

  List<PageAnalyticsModel> get pages =>
      _pages;

  //----------------------------------------------------------
  // Customer Regions
  //----------------------------------------------------------

  List<CustomerRegionModel> _regions = [];

  List<CustomerRegionModel> get regions =>
      _regions;

  //----------------------------------------------------------
  // Device Analytics
  //----------------------------------------------------------

  List<DeviceAnalyticsModel> _devices = [];

  List<DeviceAnalyticsModel> get devices =>
      _devices;

  //----------------------------------------------------------
  // Traffic Sources
  //----------------------------------------------------------

  List<TrafficSourceModel> _sources = [];

  List<TrafficSourceModel> get sources =>
      _sources;

  //----------------------------------------------------------
  // Inventory Analytics
  //----------------------------------------------------------

  InventoryAnalyticsModel? _inventory;

  InventoryAnalyticsModel? get inventory =>
      _inventory;

  //----------------------------------------------------------
  // Load Dashboard
  //----------------------------------------------------------

  Future<void> loadDashboard() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final results = await Future.wait([
        AnalyticsRepository.getSummary(),
        AnalyticsRepository.getSalesChart(),
        AnalyticsRepository.getPageAnalytics(),
        AnalyticsRepository.getCustomerRegions(),
        AnalyticsRepository.getDeviceAnalytics(),
        AnalyticsRepository.getTrafficSources(),
        AnalyticsRepository.getInventoryAnalytics(),
        AnalyticsRepository.getBestSellingProducts(),
  AnalyticsRepository.getLowStockProducts(),
      ]);

      _summary =
          results[0] as AnalyticsSummaryModel;

      _salesChart =
          results[1] as List<SalesChartModel>;

      _pages =
          results[2] as List<PageAnalyticsModel>;

      _regions =
          results[3] as List<CustomerRegionModel>;

      _devices =
          results[4] as List<DeviceAnalyticsModel>;

      _sources =
          results[5] as List<TrafficSourceModel>;

      _inventory =
          results[6] as InventoryAnalyticsModel;
          
_bestSellingProducts =
    results[7]
        as List<Map<String, dynamic>>;

_lowStockProducts =
    results[8]
        as List<Map<String, dynamic>>;

    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }


//----------------------------------------------------------
// Best Selling Products
//----------------------------------------------------------

List<Map<String, dynamic>>
    _bestSellingProducts = [];

List<Map<String, dynamic>>
    get bestSellingProducts =>
        _bestSellingProducts;


// Low Stock
//----------------------------------------------------------

List<Map<String, dynamic>>
    _lowStockProducts = [];

List<Map<String, dynamic>>
    get lowStockProducts =>
        _lowStockProducts;


  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refresh() async {
    await loadDashboard();
  }

  //----------------------------------------------------------
  // Helpers
  //----------------------------------------------------------

  double get revenue =>
      _summary?.totalRevenue ?? 0;

  int get orders =>
      _summary?.totalOrders ?? 0;

  int get customers =>
      _summary?.totalCustomers ?? 0;

  int get products =>
      _summary?.totalProducts ?? 0;

  double get averageOrder =>
      _summary?.averageOrderValue ?? 0;

  int get visitors =>
      _summary?.totalVisitors ?? 0;
}