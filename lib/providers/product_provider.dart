import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  // ==========================
  // Product Lists
  // ==========================

  List<ProductModel> _products = [];
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _newArrivals = [];
  List<ProductModel> _bestSellers = [];

  // ==========================
  // State
  // ==========================

  bool _loading = false;
  String? _error;

  // ==========================
  // Getters
  // ==========================

  List<ProductModel> get products => _products;

  List<ProductModel> get featuredProducts => _featuredProducts;

  List<ProductModel> get newArrivals => _newArrivals;

  List<ProductModel> get bestSellers => _bestSellers;

  bool get loading => _loading;

  String? get error => _error;

  // ==========================
  // Load Homepage Products
  // ==========================

  Future<void> loadHomeProducts() async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      // --------------------------------
      // ALL PRODUCTS
      // --------------------------------
      try {
        _products = await ProductRepository.getProducts();

        debugPrint('PRODUCTS: Loaded ${_products.length} products');
      } catch (e, stackTrace) {
        debugPrint('PRODUCTS ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }

      // --------------------------------
      // FEATURED
      // --------------------------------
      try {
        _featuredProducts = await ProductRepository.getFeaturedProducts();

        debugPrint('FEATURED: Loaded ${_featuredProducts.length} products');

        for (final product in _featuredProducts) {
          debugPrint(
            'FEATURED PRODUCT: ${product.name} | '
            '${product.createdAt}',
          );
        }
      } catch (e, stackTrace) {
        debugPrint('FEATURED ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }

      // --------------------------------
      // NEW ARRIVALS
      // --------------------------------
      try {
        _newArrivals = await ProductRepository.getNewArrivals();

        debugPrint('NEW ARRIVALS: Loaded ${_newArrivals.length} products');

        for (final product in _newArrivals) {
          debugPrint(
            'NEW ARRIVAL PRODUCT: ${product.name} | '
            'createdAt: ${product.createdAt} | '
            'newArrival: ${product.newArrival} | '
            'status: ${product.status}',
          );
        }
      } catch (e, stackTrace) {
        debugPrint('NEW ARRIVALS ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }

      // --------------------------------
      // BEST SELLERS
      // --------------------------------
      try {
        _bestSellers = await ProductRepository.getBestSellers();

        debugPrint('BEST SELLERS: Loaded ${_bestSellers.length} products');
      } catch (e, stackTrace) {
        debugPrint('BEST SELLERS ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }
    } catch (e, stackTrace) {
      _error = e.toString();

      debugPrint('HOME PRODUCTS ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ==========================
  // Load All Products
  // ==========================

  Future<void> loadProducts() async {
    try {
      _products = await ProductRepository.getProducts();

      _error = null;

      debugPrint('PRODUCTS: Loaded ${_products.length} products');
    } catch (e, stackTrace) {
      _error = e.toString();

      debugPrint('PRODUCTS ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    notifyListeners();
  }

  // ==========================
  // Featured Products
  // ==========================

  Future<void> loadFeaturedProducts() async {
    try {
      _featuredProducts = await ProductRepository.getFeaturedProducts();

      _error = null;

      debugPrint('FEATURED: Loaded ${_featuredProducts.length} products');
    } catch (e, stackTrace) {
      _error = e.toString();

      debugPrint('FEATURED ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    notifyListeners();
  }

  // ==========================
  // New Arrivals
  // ==========================

  Future<void> loadNewArrivals() async {
    try {
      _newArrivals = await ProductRepository.getNewArrivals();

      _error = null;

      debugPrint('NEW ARRIVALS: Loaded ${_newArrivals.length} products');

      for (final product in _newArrivals) {
        debugPrint(
          'NEW ARRIVAL: ${product.name} | '
          'createdAt: ${product.createdAt} | '
          'newArrival: ${product.newArrival} | '
          'status: ${product.status}',
        );
      }
    } catch (e, stackTrace) {
      _error = e.toString();

      debugPrint('NEW ARRIVALS ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    notifyListeners();
  }

  // ==========================
  // Best Sellers
  // ==========================

  Future<void> loadBestSellers() async {
    try {
      _bestSellers = await ProductRepository.getBestSellers();

      _error = null;

      debugPrint('BEST SELLERS: Loaded ${_bestSellers.length} products');
    } catch (e, stackTrace) {
      _error = e.toString();

      debugPrint('BEST SELLERS ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    notifyListeners();
  }

  // ==========================
  // Category Products
  // ==========================

  Future<List<ProductModel>> getCategoryProducts(String category) async {
    return ProductRepository.getCategoryProducts(category);
  }

  // ==========================
  // Refresh Everything
  // ==========================

  Future<void> refresh() async {
    await loadHomeProducts();
  }
}
