import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id;

  final String productId;

  final String productName;

  final String productImage;

  final double price;

  final int quantity;

  final String size;

  final String color;

  final Timestamp? addedAt;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.size,
    required this.color,
    this.addedAt,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
      'addedAt': addedAt,
    };
  }

  factory CartItemModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CartItemModel(
      id: id,
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 1,
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      addedAt: map['addedAt'],
    );
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
    String? size,
    String? color,
    Timestamp? addedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}