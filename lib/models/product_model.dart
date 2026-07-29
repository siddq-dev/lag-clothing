import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_image_model.dart';
import 'product_seo_model.dart';
import 'product_variant_model.dart';

class ProductModel {
  final String id;

  final String name;

  final String description;

  final String brand;

  final String category;

  final String subCategory;

  final double price;

  final double salePrice;

  final int stock;

  final double rating;

  final int reviewCount;

  final bool featured;

  final bool bestSeller;

  final bool newArrival;

  final bool status;

  final List<ProductImageModel> images;

  final List<ProductVariantModel> variants;

  final ProductSeoModel seo;

  final Timestamp? createdAt;

  final Timestamp? updatedAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.subCategory,
    required this.price,
    required this.salePrice,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.featured,
    required this.bestSeller,
    required this.newArrival,
    required this.status,
    required this.images,
    required this.variants,
    required this.seo,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'category': category,
      'subCategory': subCategory,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'featured': featured,
      'bestSeller': bestSeller,
      'newArrival': newArrival,
      'status': status,
      'images':
          images.map((e) => e.toMap()).toList(),
      'variants':
          variants.map((e) => e.toMap()).toList(),
      'seo': seo.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProductModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      salePrice:
          (map['salePrice'] ?? 0).toDouble(),
      stock: map['stock'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      featured: map['featured'] ?? false,
      bestSeller: map['bestSeller'] ?? false,
      newArrival: map['newArrival'] ?? false,
      status: map['status'] ?? true,
      images: (map['images'] as List<dynamic>? ?? [])
          .map((e) => ProductImageModel.fromMap(e))
          .toList(),
      variants:
          (map['variants'] as List<dynamic>? ?? [])
              .map(
                (e) =>
                    ProductVariantModel.fromMap(e),
              )
              .toList(),
      seo: ProductSeoModel.fromMap(
        map['seo'] ?? {},
      ),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? brand,
    String? category,
    String? subCategory,
    double? price,
    double? salePrice,
    int? stock,
    double? rating,
    int? reviewCount,
    bool? featured,
    bool? bestSeller,
    bool? newArrival,
    bool? status,
    List<ProductImageModel>? images,
    List<ProductVariantModel>? variants,
    ProductSeoModel? seo,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description:
          description ?? this.description,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      subCategory:
          subCategory ?? this.subCategory,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount:
          reviewCount ?? this.reviewCount,
      featured: featured ?? this.featured,
      bestSeller:
          bestSeller ?? this.bestSeller,
      newArrival:
          newArrival ?? this.newArrival,
      status: status ?? this.status,
      images: images ?? this.images,
      variants: variants ?? this.variants,
      seo: seo ?? this.seo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}