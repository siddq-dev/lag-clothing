import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductRepository {
  ProductRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('products');

  // ============================================================
  // Get All Active Products
  // Newest products are returned first.
  // ============================================================

  static Future<List<ProductModel>> getProducts() async {
    final snapshot = await _collection
        .where('status', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), documentId: doc.id))
        .toList();
  }

  // ============================================================
  // Stream All Active Products
  // Newest products are returned first.
  // ============================================================

  static Stream<List<ProductModel>> streamProducts() {
    return _collection
        .where('status', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ProductModel.fromMap(doc.data(), documentId: doc.id),
              )
              .toList(),
        );
  }

  // ============================================================
  // Featured Products
  // ============================================================

  static Future<List<ProductModel>> getFeaturedProducts() async {
    return _getFlaggedProducts(flagField: 'featured');
  }

  // ============================================================
  // New Arrivals
  // ============================================================

  static Future<List<ProductModel>> getNewArrivals() async {
    return _getFlaggedProducts(flagField: 'newArrival');
  }

  // ============================================================
  // Best Sellers
  // ============================================================

  static Future<List<ProductModel>> getBestSellers() async {
    return _getFlaggedProducts(flagField: 'bestSeller');
  }

  // ============================================================
  // Homepage Flagged Products
  //
  // Important:
  // 1. Only active products are considered.
  // 2. Only products where the requested flag is true.
  // 3. Newest created products come first.
  // 4. Homepage displays only the latest 2.
  //
  // Example:
  //
  // featured = true:
  //
  // Product A - Aug 10
  // Product B - Aug 08
  // Product C - Aug 01
  //
  // Homepage gets:
  // Product A
  // Product B
  //
  // Product C is automatically excluded.
  // ============================================================

  static Future<List<ProductModel>> _getFlaggedProducts({
    required String flagField,
  }) async {
    final snapshot = await _collection
        .where(flagField, isEqualTo: true)
        .where('status', isEqualTo: true)
        .get();

    final products = snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), documentId: doc.id))
        .toList();

    // ==========================================================
    // Sort newest -> oldest
    //
    // Products with a createdAt timestamp come first.
    // Among them, the newest timestamp comes first.
    //
    // Products without createdAt are placed at the bottom.
    // ==========================================================

    products.sort((a, b) {
      final aDate = a.createdAt?.toDate();
      final bDate = b.createdAt?.toDate();

      // Both have no createdAt.
      if (aDate == null && bDate == null) {
        return 0;
      }

      // Products with a date come before products without one.
      if (aDate == null) {
        return 1;
      }

      if (bDate == null) {
        return -1;
      }

      // Newest first.
      return bDate.compareTo(aDate);
    });

    // ==========================================================
    // Homepage only shows the latest 2 selected products.
    // ==========================================================

    return products.take(2).toList();
  }

  // ============================================================
  // Category Products
  //
  // Newest products first.
  // ============================================================

  static Future<List<ProductModel>> getCategoryProducts(String category) async {
    final snapshot = await _collection
        .where('category', isEqualTo: category)
        .where('status', isEqualTo: true)
        .get();

    final products = snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), documentId: doc.id))
        .toList();

    // Newest category products first.
    products.sort((a, b) {
      final aDate = a.createdAt?.toDate();
      final bDate = b.createdAt?.toDate();

      if (aDate == null && bDate == null) {
        return 0;
      }

      if (aDate == null) {
        return 1;
      }

      if (bDate == null) {
        return -1;
      }

      return bDate.compareTo(aDate);
    });

    return products.take(2).toList();
  }

  // ============================================================
  // Single Product
  // ============================================================

  static Future<ProductModel?> getProduct(String productId) async {
    final snapshot = await _collection.doc(productId).get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return ProductModel.fromMap(data, documentId: snapshot.id);
  }
}
