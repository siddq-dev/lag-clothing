class CustomerRegionModel {
  final String country;

  final int customers;

  final int orders;

  final double revenue;

  const CustomerRegionModel({
    required this.country,
    required this.customers,
    required this.orders,
    required this.revenue,
  });

  factory CustomerRegionModel.fromMap(Map<String, dynamic> map) {
    return CustomerRegionModel(
      country: map['country'] ?? '',
      customers: map['customers'] ?? 0,
      orders: map['orders'] ?? 0,
      revenue: (map['revenue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'customers': customers,
      'orders': orders,
      'revenue': revenue,
    };
  }
}
