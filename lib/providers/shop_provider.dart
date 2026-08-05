import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../repositories/shop_repository.dart';

class ShopProvider extends ChangeNotifier {
  final ShopRepository _repository = ShopRepository();

  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];

  bool _loading = false;
  String? _error;

  String _search = "";

  final Set<String> selectedCategories = {};
  final Set<String> selectedBrands = {};
  final Set<String> selectedSizes = {};
  final Set<String> selectedPrices = {};
  final Set<String> selectedAvailability = {};

  bool get isLoading => _loading;

  String? get error => _error;

  List<ProductModel> get products => _filteredProducts;

  Future<void> loadProducts() async {
  print("ShopProvider.loadProducts() called");

  _loading = true;
  _error = null;
  notifyListeners();

  try {
    _products = await _repository.getProducts();

    print("Products loaded: ${_products.length}");

    _filteredProducts = List.from(_products);
  } catch (e, stack) {
    print("ERROR: $e");
    print(stack);

    _error = e.toString();
  }

  _loading = false;
  notifyListeners();
}

  //---------------------------------------
  // Search
  //---------------------------------------

  void updateSearch(String value) {
    _search = value.toLowerCase();

    _applyFilters();
  }

  //---------------------------------------
  // Category
  //---------------------------------------

  void toggleCategory(String value) {
    if (selectedCategories.contains(value)) {
      selectedCategories.remove(value);
    } else {
      selectedCategories.add(value);
    }

    _applyFilters();
  }

  //---------------------------------------
  // Brand
  //---------------------------------------

  void toggleBrand(String value) {
    if (selectedBrands.contains(value)) {
      selectedBrands.remove(value);
    } else {
      selectedBrands.add(value);
    }

    _applyFilters();
  }

  //---------------------------------------
  // Size
  //---------------------------------------

  void toggleSize(String value) {
    if (selectedSizes.contains(value)) {
      selectedSizes.remove(value);
    } else {
      selectedSizes.add(value);
    }

    _applyFilters();
  }

  //---------------------------------------
  // Price
  //---------------------------------------

  void togglePrice(String value) {
    if (selectedPrices.contains(value)) {
      selectedPrices.remove(value);
    } else {
      selectedPrices.add(value);
    }

    _applyFilters();
  }

  //---------------------------------------
  // Availability
  //---------------------------------------

  void toggleAvailability(String value) {
    if (selectedAvailability.contains(value)) {
      selectedAvailability.remove(value);
    } else {
      selectedAvailability.add(value);
    }

    _applyFilters();
  }

  //---------------------------------------
  // Clear
  //---------------------------------------

  void clearFilters() {
    _search = "";

    selectedCategories.clear();
    selectedBrands.clear();
    selectedSizes.clear();
    selectedPrices.clear();
    selectedAvailability.clear();

    _applyFilters();
  }

  //---------------------------------------
  // Filter Logic
  //---------------------------------------

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      if (_search.isNotEmpty) {
        final text =
            "${product.name} ${product.brand} ${product.category}"
                .toLowerCase();

        if (!text.contains(_search)) {
          return false;
        }
      }

      if (selectedCategories.isNotEmpty &&
          !selectedCategories.contains(product.category)) {
        return false;
      }

      if (selectedBrands.isNotEmpty &&
          !selectedBrands.contains(product.brand)) {
        return false;
      }

      if (selectedSizes.isNotEmpty) {
        final sizes = product.variants
            .map((e) => e.size)
            .toSet();

        if (!sizes.any(selectedSizes.contains)) {
          return false;
        }
      }

      if (selectedAvailability.contains("In Stock") &&
          product.stock <= 0) {
        return false;
      }

      if (selectedAvailability.contains("Out of Stock") &&
          product.stock > 0) {
        return false;
      }

      if (selectedPrices.isNotEmpty) {
        bool matched = false;

        for (final range in selectedPrices) {
          switch (range) {
            case "₹500 - ₹1000":
              matched |= product.price >= 500 &&
                  product.price <= 1000;
              break;

            case "₹1000 - ₹1500":
              matched |= product.price >= 1000 &&
                  product.price <= 1500;
              break;

            case "₹1500 - ₹2000":
              matched |= product.price >= 1500 &&
                  product.price <= 2000;
              break;

            case "₹2000+":
              matched |= product.price >= 2000;
              break;
          }
        }

        if (!matched) {
          return false;
        }
      }

      return true;
    }).toList();

    notifyListeners();
  }

  //---------------------------------------
  // Dynamic Filters
  //---------------------------------------

  List<String> get categories =>
      _products
          .map((e) => e.category)
          .toSet()
          .toList()
        ..sort();

  List<String> get brands =>
      _products
          .map((e) => e.brand)
          .toSet()
          .toList()
        ..sort();
}