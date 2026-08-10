import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../repositories/shop_repository.dart';

class ShopProvider extends ChangeNotifier {
  final ShopRepository _repository = ShopRepository();

  //==================================================
  // DATA
  //==================================================

  List<ProductModel> _products = [];

  List<ProductModel> _filteredProducts = [];

  StreamSubscription<List<ProductModel>>? _productsSubscription;

  //==================================================
  // STATE
  //==================================================

  bool _loading = false;

  String? _error;

  String _search = '';

  //==================================================
  // FILTERS
  //==================================================

  final Set<String> selectedCategories = {};

  final Set<String> selectedBrands = {};

  final Set<String> selectedSizes = {};

  final Set<String> selectedPrices = {};

  final Set<String> selectedAvailability = {};

  //==================================================
  // GETTERS
  //==================================================

  bool get isLoading => _loading;

  String? get error => _error;

  List<ProductModel> get products => _filteredProducts;

  List<ProductModel> get allProducts => _products;

  //==================================================
  // LOAD PRODUCTS
  //==================================================

  void loadProducts() {
    print('======================================');
    print('ShopProvider.loadProducts()');
    print('======================================');

    _loading = true;
    _error = null;

    notifyListeners();

    _productsSubscription?.cancel();

    _productsSubscription = _repository.streamProducts().listen(
      (products) {
        print('ShopProvider received ${products.length} products');

        _products = products;

        _applyFilters();

        _loading = false;
        _error = null;

        notifyListeners();
      },
      onError: (error, stackTrace) {
        print('======================================');
        print('SHOP PROVIDER ERROR');
        print(error);
        print(stackTrace);
        print('======================================');

        _loading = false;
        _error = error.toString();

        notifyListeners();
      },
    );
  }

  //==================================================
  // SEARCH
  //==================================================

  void updateSearch(String value) {
    _search = value.trim().toLowerCase();

    _applyFilters();
  }

  //==================================================
  // CATEGORY
  //==================================================

  void toggleCategory(String value) {
    if (selectedCategories.contains(value)) {
      selectedCategories.remove(value);
    } else {
      selectedCategories.add(value);
    }

    _applyFilters();
  }

  //==================================================
  // BRAND
  //==================================================

  void toggleBrand(String value) {
    if (selectedBrands.contains(value)) {
      selectedBrands.remove(value);
    } else {
      selectedBrands.add(value);
    }

    _applyFilters();
  }

  //==================================================
  // SIZE
  //==================================================

  void toggleSize(String value) {
    if (selectedSizes.contains(value)) {
      selectedSizes.remove(value);
    } else {
      selectedSizes.add(value);
    }

    _applyFilters();
  }

  //==================================================
  // PRICE
  //==================================================

  void togglePrice(String value) {
    if (selectedPrices.contains(value)) {
      selectedPrices.remove(value);
    } else {
      selectedPrices.add(value);
    }

    _applyFilters();
  }

  //==================================================
  // AVAILABILITY
  //==================================================

  void toggleAvailability(String value) {
    if (selectedAvailability.contains(value)) {
      selectedAvailability.remove(value);
    } else {
      selectedAvailability.add(value);
    }

    _applyFilters();
  }

  //==================================================
  // CLEAR FILTERS
  //==================================================

  void clearFilters() {
    _search = '';

    selectedCategories.clear();
    selectedBrands.clear();
    selectedSizes.clear();
    selectedPrices.clear();
    selectedAvailability.clear();

    _applyFilters();
  }

  //==================================================
  // FILTER LOGIC
  //==================================================

  void _applyFilters() {
    Iterable<ProductModel> result = _products;

    // SEARCH
    if (_search.isNotEmpty) {
      result = result.where((product) {
        final text =
            '${product.name} '
                    '${product.brand} '
                    '${product.category} '
                    '${product.subCategory}'
                .toLowerCase();

        return text.contains(_search);
      });
    }

    // CATEGORY
    if (selectedCategories.isNotEmpty) {
      result = result.where(
        (product) => selectedCategories.contains(product.category),
      );
    }

    // BRAND
    if (selectedBrands.isNotEmpty) {
      result = result.where(
        (product) => selectedBrands.contains(product.brand),
      );
    }

    // SIZE
    if (selectedSizes.isNotEmpty) {
      result = result.where((product) {
        return product.variants.any(
          (variant) => selectedSizes.contains(variant.size),
        );
      });
    }

    // AVAILABILITY
    if (selectedAvailability.isNotEmpty) {
      result = result.where((product) {
        bool matches = false;

        if (selectedAvailability.contains('In Stock') && product.stock > 0) {
          matches = true;
        }

        if (selectedAvailability.contains('Out of Stock') &&
            product.stock <= 0) {
          matches = true;
        }

        return matches;
      });
    }

    // PRICE
    if (selectedPrices.isNotEmpty) {
      result = result.where((product) {
        final price = product.salePrice > 0 ? product.salePrice : product.price;

        for (final range in selectedPrices) {
          switch (range) {
            case '₹500 - ₹1000':
              if (price >= 500 && price <= 1000) {
                return true;
              }
              break;

            case '₹1000 - ₹1500':
              if (price >= 1000 && price <= 1500) {
                return true;
              }
              break;

            case '₹1500 - ₹2000':
              if (price >= 1500 && price <= 2000) {
                return true;
              }
              break;

            case '₹2000+':
              if (price >= 2000) {
                return true;
              }
              break;
          }
        }

        return false;
      });
    }

    _filteredProducts = result.toList();

    notifyListeners();
  }

  //==================================================
  // DYNAMIC CATEGORIES
  //==================================================

  List<String> get categories {
    return _products
        .map((product) => product.category)
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  //==================================================
  // DYNAMIC BRANDS
  //==================================================

  List<String> get brands {
    return _products
        .map((product) => product.brand)
        .where((brand) => brand.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  //==================================================
  // DISPOSE
  //==================================================

  @override
  void dispose() {
    _productsSubscription?.cancel();

    super.dispose();
  }
}
