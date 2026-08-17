class InventoryAnalyticsModel {
  final int totalProducts;

  final int inStock;

  final int lowStock;

  final int outOfStock;

  final double inventoryValue;

  const InventoryAnalyticsModel({
    required this.totalProducts,
    required this.inStock,
    required this.lowStock,
    required this.outOfStock,
    required this.inventoryValue,
  });

  factory InventoryAnalyticsModel.fromMap(Map<String, dynamic> map) {
    return InventoryAnalyticsModel(
      totalProducts: map['totalProducts'] ?? 0,
      inStock: map['inStock'] ?? 0,
      lowStock: map['lowStock'] ?? 0,
      outOfStock: map['outOfStock'] ?? 0,
      inventoryValue: (map['inventoryValue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalProducts': totalProducts,
      'inStock': inStock,
      'lowStock': lowStock,
      'outOfStock': outOfStock,
      'inventoryValue': inventoryValue,
    };
  }
}
