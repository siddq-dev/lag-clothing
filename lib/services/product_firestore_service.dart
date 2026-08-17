import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/product_model.dart';

class ProductFirestoreService {
  ProductFirestoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection("products");

  // ==========================
  // Get All Products
  // ==========================

  static Future<List<ProductModel>> getProducts() async {
    final snapshot = await _collection
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();
  }

  // ==========================
  // Create Product
  // ==========================

  static Future<void> createProduct(ProductModel product) async {
    await _collection.doc(product.id).set(product.toMap());
  }

  // ==========================
  // Update Product
  // ==========================

  static Future<void> updateProduct(ProductModel product) async {
    await _collection.doc(product.id).update(product.toMap());
  }

  // ==========================
  // Delete Product
  // ==========================

  static Future<void> deleteProduct(String productId) async {
    await _collection.doc(productId).delete();
  }

  // ==========================
  // Get Single Product
  // ==========================

  static Future<ProductModel?> getProduct(String id) async {
    final doc = await _collection.doc(id).get();

    if (!doc.exists) {
      return null;
    }

    return ProductModel.fromMap(doc.data()!);
  }
}
