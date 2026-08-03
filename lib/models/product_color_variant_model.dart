import '../../../../models/product_variant_model.dart';

class ProductColorVariantModel {
  final String color;
  final List<ProductVariantModel> variants;

  const ProductColorVariantModel({
    required this.color,
    required this.variants,
  });

  ProductColorVariantModel copyWith({
    String? color,
    List<ProductVariantModel>? variants,
  }) {
    return ProductColorVariantModel(
      color: color ?? this.color,
      variants: variants ?? this.variants,
    );
  }
}