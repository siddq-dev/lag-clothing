import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/product_model.dart';

class ShopRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  //==================================================
  // Get Products
  //==================================================

  Future<List<ProductModel>> getProducts({
  int limit = 20,
  DocumentSnapshot? lastDocument,
}) async {
  Query<Map<String, dynamic>> query =
      _products.limit(limit);

  if (lastDocument != null) {
    query = query.startAfterDocument(lastDocument);
  }

  final snapshot = await query.get();

  print("==================================");
  print("Products Count: ${snapshot.docs.length}");
  print("==================================");

  for (final doc in snapshot.docs) {
    print(doc.id);
    print(doc.data());
  }

  return snapshot.docs
      .map((e) => ProductModel.fromMap(e.data()))
      .toList();
}

  //==================================================
  // Featured
  //==================================================

  Future<List<ProductModel>> getFeaturedProducts() async {
    final products = await getProducts();

    return products
        .where((e) => e.featured)
        .toList();
  }

  //==================================================
  // Best Seller
  //==================================================

  Future<List<ProductModel>> getBestSellerProducts() async {
    final products = await getProducts();

    return products
        .where((e) => e.bestSeller)
        .toList();
  }

  //==================================================
  // New Arrival
  //==================================================

  Future<List<ProductModel>> getNewArrivalProducts() async {
    final products = await getProducts();

    return products
        .where((e) => e.newArrival)
        .toList();
  }

  //==================================================
  // Category
  //==================================================

  Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    final products = await getProducts();

    return products
        .where((e) => e.category == category)
        .toList();
  }

  //==================================================
  // Search
  //==================================================

  Future<List<ProductModel>> searchProducts(
    String keyword,
  ) async {
    final products = await getProducts();

    return products.where((product) {
      return product.name
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          product.brand
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();
  }

  //==================================================
  // Single Product
  //==================================================

  Future<ProductModel?> getProduct(
    String id,
  ) async {
    final snapshot = await _products.doc(id).get();

    if (!snapshot.exists) {
      return null;
    }

    return ProductModel.fromMap(
      snapshot.data()!,
    );
  }
}