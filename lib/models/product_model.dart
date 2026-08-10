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
      'images': images.map((e) => e.toMap()).toList(),
      'variants': variants.map((e) => e.toMap()).toList(),
      'seo': seo.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return ProductModel(
      // Use Firestore document ID if the stored id is empty.
      id: (map['id'] ?? '').toString().isNotEmpty
          ? map['id'].toString()
          : (documentId ?? ''),

      name: (map['name'] ?? '').toString(),

      description: (map['description'] ?? '').toString(),

      brand: (map['brand'] ?? '').toString(),

      category: (map['category'] ?? '').toString(),

      subCategory: (map['subCategory'] ?? '').toString(),

      price: _toDouble(map['price']),

      salePrice: _toDouble(map['salePrice']),

      stock: _toInt(map['stock']),

      rating: _toDouble(map['rating']),

      reviewCount: _toInt(map['reviewCount']),

      featured: _toBool(map['featured']),

      bestSeller: _toBool(map['bestSeller']),

      newArrival: _toBool(map['newArrival']),

      status: map['status'] == null ? true : _toBool(map['status']),

      images: _parseImages(map['images']),

      variants: _parseVariants(map['variants']),

      seo: ProductSeoModel.fromMap(
        map['seo'] is Map ? Map<String, dynamic>.from(map['seo']) : {},
      ),

      createdAt: map['createdAt'] is Timestamp
          ? map['createdAt'] as Timestamp
          : null,

      updatedAt: map['updatedAt'] is Timestamp
          ? map['updatedAt'] as Timestamp
          : null,
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
      description: description ?? this.description,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      featured: featured ?? this.featured,
      bestSeller: bestSeller ?? this.bestSeller,
      newArrival: newArrival ?? this.newArrival,
      status: status ?? this.status,
      images: images ?? this.images,
      variants: variants ?? this.variants,
      seo: seo ?? this.seo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }

  static int _toInt(dynamic value) {
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    if (value is num) {
      return value != 0;
    }

    return false;
  }

  static List<ProductImageModel> _parseImages(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .whereType<Map>()
        .map((e) => ProductImageModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static List<ProductVariantModel> _parseVariants(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .whereType<Map>()
        .map((e) => ProductVariantModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
