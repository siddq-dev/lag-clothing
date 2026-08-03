class ProductVariantModel {
  final String id;

  final String color;
  final String size;

  final String sku;

  final int stock;

  final bool available;

  final double additionalPrice;

  const ProductVariantModel({
    required this.id,
    required this.color,
    required this.size,
    required this.sku,
    required this.stock,
    required this.available,
    required this.additionalPrice,
  });

  ProductVariantModel copyWith({
    String? id,
    String? color,
    String? size,
    String? sku,
    int? stock,
    bool? available,
    double? additionalPrice,
  }) {
    return ProductVariantModel(
      id: id ?? this.id,
      color: color ?? this.color,
      size: size ?? this.size,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      available: available ?? this.available,
      additionalPrice:
          additionalPrice ?? this.additionalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "color": color,
      "size": size,
      "sku": sku,
      "stock": stock,
      "available": available,
      "additionalPrice": additionalPrice,
    };
  }

  factory ProductVariantModel.fromMap(
      Map<String, dynamic> map) {
    return ProductVariantModel(
      id: map["id"] ?? "",
      color: map["color"] ?? "",
      size: map["size"] ?? "",
      sku: map["sku"] ?? "",
      stock: map["stock"] ?? 0,
      available: map["available"] ?? true,
      additionalPrice:
          (map["additionalPrice"] ?? 0).toDouble(),
    );
  }
}