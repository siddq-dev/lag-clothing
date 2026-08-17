import 'package:cloud_firestore/cloud_firestore.dart';

enum InventoryLogType { stockIn, stockOut, manualAdjustment }

class InventoryLogModel {
  final String id;
  final String productId;
  final String productName;

  final InventoryLogType type;

  final int quantity;

  final int previousStock;

  final int newStock;

  final String reference;

  final String performedBy;

  final Timestamp? createdAt;

  const InventoryLogModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.quantity,
    required this.previousStock,
    required this.newStock,
    required this.reference,
    required this.performedBy,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productId": productId,
      "productName": productName,
      "type": type.name,
      "quantity": quantity,
      "previousStock": previousStock,
      "newStock": newStock,
      "reference": reference,
      "performedBy": performedBy,
      "createdAt": createdAt,
    };
  }
}
