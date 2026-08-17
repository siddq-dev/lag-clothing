import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItemModel {
  final String id;

  final String name;

  final String sku;

  final String category;

  final double price;

  final int stock;

  final int reorderLevel;

  final int soldCount;

  final double revenue;

  final String image;

  final bool isActive;

  final Timestamp? createdAt;

  final Timestamp? updatedAt;

  const InventoryItemModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    required this.stock,
    required this.reorderLevel,
    required this.soldCount,
    required this.revenue,
    required this.image,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory InventoryItemModel.fromMap(String id, Map<String, dynamic> map) {
    return InventoryItemModel(
      id: id,
      name: map["name"] ?? "",
      sku: map["sku"] ?? "",
      category: map["category"] ?? "",
      price: (map["price"] ?? 0).toDouble(),
      stock: map["stock"] ?? 0,
      reorderLevel: map["reorderLevel"] ?? 10,
      soldCount: map["soldCount"] ?? 0,
      revenue: (map["revenue"] ?? 0).toDouble(),
      image: map["image"] ?? "",
      isActive: map["isActive"] ?? true,
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
    );
  }
}
