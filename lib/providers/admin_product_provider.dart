import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_form_model.dart';
import '../models/product_image_model.dart';
import '../models/product_model.dart';

import '../repositories/admin_product_repository.dart';
import '../services/product_storage_service.dart';

class AdminProductProvider extends ChangeNotifier {
  bool _loading = false;

  final List<ProductModel> _products = [];

  bool get loading => _loading;

  List<ProductModel> get products => _products;

  // ==========================
  // Load Products
  // ==========================

  Future<void> loadProducts() async {
    _loading = true;
    notifyListeners();

    try {
      final data = await AdminProductRepository.getProducts();

      _products
        ..clear()
        ..addAll(data);
    } catch (e) {
      debugPrint(e.toString());
    }

    _loading = false;
    notifyListeners();
  }

  // ==========================
  // Save Product
  // ==========================

  Future<void> saveProduct({
    required ProductFormModel form,
    required List<Uint8List> images,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      final productId = AdminProductRepository.generateProductId();

      final uploadedImages = <ProductImageModel>[];

      for (int i = 0; i < images.length; i++) {
        final url = await ProductStorageService.uploadImage(
          productId: productId,
          fileName: "image_$i.jpg",
          imageBytes: images[i],
        );

        uploadedImages.add(
          ProductImageModel(id: "$i", imageUrl: url, isPrimary: i == 0),
        );
      }

      final product = ProductModel(
        id: productId,
        name: form.name,
        description: form.description,
        brand: form.brand,
        category: form.category,
        subCategory: form.subCategory,
        price: form.price,
        salePrice: form.salePrice,
        stock: form.stock,
        rating: 0,
        reviewCount: 0,
        featured: form.featured,
        bestSeller: form.bestSeller,
        newArrival: form.newArrival,
        status: form.status,
        images: uploadedImages,
        variants: form.variants,
        seo: form.seo,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await AdminProductRepository.createProduct(product);

      await loadProducts();
    } catch (e) {
      debugPrint(e.toString());
    }

    _loading = false;
    notifyListeners();
  }

  // ==========================
  // Delete Product
  // ==========================

  Future<void> deleteProduct(ProductModel product) async {
    _loading = true;
    notifyListeners();

    try {
      // Delete images from Firebase Storage
      for (final image in product.images) {
        await ProductStorageService.deleteImage(image.imageUrl);
      }

      // Delete Firestore document
      await AdminProductRepository.deleteProduct(product.id);

      await loadProducts();
    } catch (e) {
      debugPrint(e.toString());
    }

    _loading = false;
    notifyListeners();
  }

  // ==========================
  // Refresh
  // ==========================

  Future<void> refresh() async {
    await loadProducts();
  }
}
