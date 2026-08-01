import 'package:cloud_firestore/cloud_firestore.dart';

class SalesChartModel {
  final Timestamp date;

  final double revenue;

  final int orders;

  const SalesChartModel({
    required this.date,
    required this.revenue,
    required this.orders,
  });

  factory SalesChartModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return SalesChartModel(
      date: map['date'] ?? Timestamp.now(),
      revenue: (map['revenue'] ?? 0).toDouble(),
      orders: map['orders'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'revenue': revenue,
      'orders': orders,
    };
  }
}