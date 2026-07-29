import 'package:uuid/uuid.dart';

import '../../../../models/product_model.dart';

import '../services/product_firestore_service.dart';

class AdminProductRepository {
  AdminProductRepository._();

  static const Uuid _uuid = Uuid();

  // ==========================
  // Generate Product ID
  // ==========================

  static String generateProductId() {
    return _uuid.v4();
  }

  // ==========================
  // Get All Products
  // ==========================

  static Future<List<ProductModel>> getProducts() async {
    return await ProductFirestoreService.getProducts();
  }

  // ==========================
  // Create Product
  // ==========================

  static Future<void> createProduct(
    ProductModel product,
  ) async {
    await ProductFirestoreService.createProduct(
      product,
    );
  }

  // ==========================
  // Update Product
  // ==========================

  static Future<void> updateProduct(
    ProductModel product,
  ) async {
    await ProductFirestoreService.updateProduct(
      product,
    );
  }

  // ==========================
  // Delete Product
  // ==========================

  static Future<void> deleteProduct(
    String productId,
  ) async {
    await ProductFirestoreService.deleteProduct(
      productId,
    );
  }

  // ==========================
  // Refresh Products
  // ==========================

  static Future<List<ProductModel>> refresh() async {
    return await getProducts();
  }
}