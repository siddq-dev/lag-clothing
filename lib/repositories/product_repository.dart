import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductRepository {
  ProductRepository._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>>
      get _collection =>
          _firestore.collection('products');

  // ==========================
  // Get All Products
  // ==========================

  static Future<List<ProductModel>> getProducts() async {
    final snapshot = await _collection
        .where('status', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

  // ==========================
// Create Product
// ==========================

static Future<ProductModel> createProduct(
  ProductModel product,
) async {
  final doc = _collection.doc();

  final newProduct = product.copyWith(
    id: doc.id,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  );

  await doc.set(newProduct.toMap());

  return newProduct;
}
  // ==========================
  // Stream Products
  // ==========================

  static Stream<List<ProductModel>> streamProducts() {
    return _collection
        .where('status', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => ProductModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  // ==========================
  // Featured Products
  // ==========================

  static Future<List<ProductModel>>
      getFeaturedProducts() async {
    final snapshot = await _collection
        .where('featured', isEqualTo: true)
        .where('status', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

  // ==========================
  // New Arrivals
  // ==========================

  static Future<List<ProductModel>>
      getNewArrivals() async {
    final snapshot = await _collection
        .where('newArrival', isEqualTo: true)
        .where('status', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

  // ==========================
  // Best Sellers
  // ==========================

  static Future<List<ProductModel>>
      getBestSellers() async {
    final snapshot = await _collection
        .where('bestSeller', isEqualTo: true)
        .where('status', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

  // ==========================
  // Category
  // ==========================

  static Future<List<ProductModel>>
      getCategoryProducts(
    String category,
  ) async {
    final snapshot = await _collection
        .where('category', isEqualTo: category)
        .where('status', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromMap(e.data()))
        .toList();
  }

  // ==========================
  // Single Product
  // ==========================

  static Future<ProductModel?> getProduct(
    String productId,
  ) async {
    final snapshot =
        await _collection.doc(productId).get();

    if (!snapshot.exists) {
      return null;
    }

    return ProductModel.fromMap(
      snapshot.data()!,
    );
  }
}