class AnalyticsSummaryModel {
  final double totalRevenue;

  final int totalOrders;

  final int totalCustomers;

  final int totalProducts;

  final double averageOrderValue;

  final int todayVisitors;

  final int totalVisitors;

  const AnalyticsSummaryModel({
    required this.totalRevenue,
    required this.totalOrders,
    required this.totalCustomers,
    required this.totalProducts,
    required this.averageOrderValue,
    required this.todayVisitors,
    required this.totalVisitors,
  });

  factory AnalyticsSummaryModel.fromMap(Map<String, dynamic> map) {
    return AnalyticsSummaryModel(
      totalRevenue: (map['totalRevenue'] ?? 0).toDouble(),
      totalOrders: map['totalOrders'] ?? 0,
      totalCustomers: map['totalCustomers'] ?? 0,
      totalProducts: map['totalProducts'] ?? 0,
      averageOrderValue: (map['averageOrderValue'] ?? 0).toDouble(),
      todayVisitors: map['todayVisitors'] ?? 0,
      totalVisitors: map['totalVisitors'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalRevenue': totalRevenue,
      'totalOrders': totalOrders,
      'totalCustomers': totalCustomers,
      'totalProducts': totalProducts,
      'averageOrderValue': averageOrderValue,
      'todayVisitors': todayVisitors,
      'totalVisitors': totalVisitors,
    };
  }
}
