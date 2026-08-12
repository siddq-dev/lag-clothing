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

  /// Current stock of the exact selected size + color variant.
  ///
  /// This is nullable because older cart documents may not contain
  /// stock information yet.
  final int? availableStock;

  /// Whether the exact selected variant is currently available.
  final bool isAvailable;

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
    this.availableStock,
    this.isAvailable = true,
    this.addedAt,
  });

  // ============================================================
  // TOTAL
  // ============================================================

  double get total => price * quantity;

  // ============================================================
  // STOCK VALIDATION
  // ============================================================

  bool get quantityExceedsStock {
    if (availableStock == null) {
      return false;
    }

    return quantity > availableStock!;
  }

  bool get canIncreaseQuantity {
    if (!isAvailable) {
      return false;
    }

    if (availableStock == null) {
      return true;
    }

    return quantity < availableStock!;
  }

  // ============================================================
  // FIRESTORE MAP
  // ============================================================

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
      'availableStock': availableStock,
      'isAvailable': isAvailable,
      'addedAt': addedAt,
    };
  }

  // ============================================================
  // FROM FIRESTORE
  // ============================================================

  factory CartItemModel.fromMap(String id, Map<String, dynamic> map) {
    return CartItemModel(
      id: id,
      productId: map['productId']?.toString() ?? '',
      productName: map['productName']?.toString() ?? '',
      productImage: map['productImage']?.toString() ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      size: map['size']?.toString() ?? '',
      color: map['color']?.toString() ?? '',
      availableStock: (map['availableStock'] as num?)?.toInt(),
      isAvailable: map['isAvailable'] is bool
          ? map['isAvailable'] as bool
          : true,
      addedAt: map['addedAt'] is Timestamp ? map['addedAt'] as Timestamp : null,
    );
  }

  // ============================================================
  // COPY WITH
  // ============================================================

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
    String? size,
    String? color,
    int? availableStock,
    bool? isAvailable,
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
      availableStock: availableStock ?? this.availableStock,
      isAvailable: isAvailable ?? this.isAvailable,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
