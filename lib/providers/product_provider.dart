import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> _featuredProducts = [];

  List<ProductModel> _newArrivals = [];

  List<ProductModel> _bestSellers = [];

  bool _loading = false;

  String? _error;

  List<ProductModel> get products =>
      _products;

  List<ProductModel> get featuredProducts =>
      _featuredProducts;

  List<ProductModel> get newArrivals =>
      _newArrivals;

  List<ProductModel> get bestSellers =>
      _bestSellers;

  bool get loading => _loading;

  String? get error => _error;

  // ==========================
  // Load All
  // ==========================

  Future<void> loadProducts() async {
    try {
      _loading = true;
      notifyListeners();

      _products =
          await ProductRepository.getProducts();

          

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  // ==========================
  // Featured
  // ==========================

  Future<void> loadFeaturedProducts() async {
    _featuredProducts =
        await ProductRepository
            .getFeaturedProducts();

    notifyListeners();
  }

  // ==========================
  // New Arrivals
  // ==========================

  Future<void> loadNewArrivals() async {
    _newArrivals =
        await ProductRepository
            .getNewArrivals();

    notifyListeners();
  }

  // ==========================
  // Best Sellers
  // ==========================

  Future<void> loadBestSellers() async {
    _bestSellers =
        await ProductRepository
            .getBestSellers();

    notifyListeners();
  }

  // ==========================
  // Category
  // ==========================

  Future<List<ProductModel>>
      getCategoryProducts(
    String category,
  ) async {
    return await ProductRepository
        .getCategoryProducts(category);
  }

  // ==========================
  // Refresh
  // ==========================

  Future<void> refresh() async {
    await Future.wait([
      loadProducts(),
      loadFeaturedProducts(),
      loadNewArrivals(),
      loadBestSellers(),
    ]);
  }
}