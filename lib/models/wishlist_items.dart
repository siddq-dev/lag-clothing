class WishlistItem {
  final String id;
  final String productId;
  final String name;
  final String category;
  final String imageUrl;

  final String size;
  final String color;

  final int quantity;
  final double price;

  const WishlistItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
  });

  // ============================================================
  // FIRESTORE
  // ============================================================

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'size': size,
      'color': color,
      'quantity': quantity,
      'price': price,
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      quantity: map['quantity'] ?? 1,
      price: (map['price'] ?? 0).toDouble(),
    );
  }

  WishlistItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? category,
    String? imageUrl,
    String? size,
    String? color,
    int? quantity,
    double? price,
  }) {
    return WishlistItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
