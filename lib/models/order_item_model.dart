import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String productId;
  final String productName;

  final String productImage;

  final String size;
  final String color;

  final int quantity;

  final double price;

  final double total;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'size': size,
      'color': color,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }

  factory OrderItemModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OrderItemModel(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
    );
  }

  OrderItemModel copyWith({
    String? productId,
    String? productName,
    String? productImage,
    String? size,
    String? color,
    int? quantity,
    double? price,
    double? total,
  }) {
    return OrderItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      total: total ?? this.total,
    );
  }
}