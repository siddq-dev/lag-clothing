class ProductImageModel {
  final String id;

  final String imageUrl;

  final bool isPrimary;

  const ProductImageModel({
    required this.id,
    required this.imageUrl,
    required this.isPrimary,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'imageUrl': imageUrl, 'isPrimary': isPrimary};
  }

  factory ProductImageModel.fromMap(Map<String, dynamic> map) {
    return ProductImageModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      isPrimary: map['isPrimary'] ?? false,
    );
  }

  ProductImageModel copyWith({String? id, String? imageUrl, bool? isPrimary}) {
    return ProductImageModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
