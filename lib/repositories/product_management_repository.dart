import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/product_model.dart';

class ProductManagementRepository {
  ProductManagementRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  //==================================================
  // Create Product
  //==================================================

  static Future<ProductModel> createProduct(ProductModel product) async {
    final doc = _products.doc();

    final newProduct = product.copyWith(
      id: doc.id,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    await doc.set(newProduct.toMap());

    return newProduct;
  }

  //==================================================
  // Update Product
  //==================================================

  static Future<void> updateProduct(ProductModel product) async {
    final updatedProduct = product.copyWith(updatedAt: Timestamp.now());

    await _products.doc(product.id).update(updatedProduct.toMap());
  }

  //==================================================
  // Delete Product
  //==================================================

  static Future<void> deleteProduct(String productId) async {
    await _products.doc(productId).delete();
  }

  //==================================================
  // Recently Added Products
  //==================================================

  static Stream<List<ProductModel>> streamRecentProducts() {
    return _products
        .orderBy("createdAt", descending: true)
        .limit(50)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => ProductModel.fromMap(e.data())).toList(),
        );
  }

  //==================================================
  // Dashboard Statistics
  //==================================================

  static Future<Map<String, int>> getStatistics() async {
    final snapshot = await _products.get();

    int active = 0;
    int inactive = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      if (data["status"] == true) {
        active++;
      } else {
        inactive++;
      }
    }

    return {
      "total": snapshot.docs.length,
      "active": active,
      "inactive": inactive,
    };
  }
}
