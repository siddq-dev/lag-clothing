class ProductVariantModel {
  final String id;

  final String size;
  final String color;

  final String sku;

  final int stock;

  final bool available;

  const ProductVariantModel({
    required this.id,
    required this.size,
    required this.color,
    required this.sku,
    required this.stock,
    required this.available,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size,
      'color': color,
      'sku': sku,
      'stock': stock,
      'available': available,
    };
  }

  factory ProductVariantModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ProductVariantModel(
      id: map['id'] ?? '',
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      sku: map['sku'] ?? '',
      stock: map['stock'] ?? 0,
      available: map['available'] ?? true,
    );
  }

  ProductVariantModel copyWith({
    String? id,
    String? size,
    String? color,
    String? sku,
    int? stock,
    bool? available,
  }) {
    return ProductVariantModel(
      id: id ?? this.id,
      size: size ?? this.size,
      color: color ?? this.color,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      available: available ?? this.available,
    );
  }
}