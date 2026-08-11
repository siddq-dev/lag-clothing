import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../models/product_variant_model.dart';
import '../repositories/shop_repository.dart';

class ProductDetailsProvider extends ChangeNotifier {
  ProductDetailsProvider({required this.productId});

  final String productId;

  final ShopRepository _repository = ShopRepository();

  ProductModel? _product;

  bool _loading = false;
  String? _error;

  String? _selectedSize;
  String? _selectedColor;

  int _quantity = 1;

  ProductModel? get product => _product;

  bool get isLoading => _loading;

  String? get error => _error;

  String? get selectedSize => _selectedSize;

  String? get selectedColor => _selectedColor;

  int get quantity => _quantity;

  // ============================================================
  // LOAD PRODUCT
  // ============================================================

  Future<void> loadProduct() async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final product = await _repository.getProduct(productId);

      if (product == null) {
        _error = 'Product not found.';
        _product = null;
      } else {
        _product = product;

        _initializeSelections(product);
      }
    } catch (e) {
      _error = e.toString();
      _product = null;
    }

    _loading = false;

    notifyListeners();
  }

  // ============================================================
  // INITIALIZE VARIANT SELECTION
  // ============================================================

  void _initializeSelections(ProductModel product) {
    final availableVariants = product.variants
        .where((variant) => variant.available && variant.stock > 0)
        .toList();

    if (availableVariants.isEmpty) {
      _selectedSize = null;
      _selectedColor = null;
      return;
    }

    final sizes = availableVariants
        .map((variant) => variant.size)
        .where((size) => size.trim().isNotEmpty)
        .toSet()
        .toList();

    if (sizes.length == 1) {
      _selectedSize = sizes.first;
    }

    final colors = availableVariants
        .map((variant) => variant.color)
        .where((color) => color.trim().isNotEmpty)
        .toSet()
        .toList();

    if (colors.length == 1) {
      _selectedColor = colors.first;
    }
  }

  // ============================================================
  // AVAILABLE SIZES
  // ============================================================

  List<String> get availableSizes {
    if (_product == null) {
      return [];
    }

    return _product!.variants
        .where(
          (variant) =>
              variant.available &&
              variant.stock > 0 &&
              variant.size.trim().isNotEmpty,
        )
        .map((variant) => variant.size.trim())
        .toSet()
        .toList();
  }

  // ============================================================
  // AVAILABLE COLORS
  // ============================================================

  List<String> get availableColors {
    if (_product == null) {
      return [];
    }

    return _product!.variants
        .where(
          (variant) =>
              variant.available &&
              variant.stock > 0 &&
              variant.color.trim().isNotEmpty,
        )
        .map((variant) => variant.color.trim())
        .toSet()
        .toList();
  }

  // ============================================================
  // SELECT SIZE
  // ============================================================

  void selectSize(String size) {
    _selectedSize = size;

    notifyListeners();
  }

  // ============================================================
  // SELECT COLOR
  // ============================================================

  void selectColor(String color) {
    _selectedColor = color;

    notifyListeners();
  }

  // ============================================================
  // SELECTED VARIANT
  // ============================================================

  ProductVariantModel? get selectedVariant {
    if (_product == null) {
      return null;
    }

    try {
      return _product!.variants.firstWhere((variant) {
        final sizeMatches =
            _selectedSize == null || variant.size == _selectedSize;

        final colorMatches =
            _selectedColor == null || variant.color == _selectedColor;

        return sizeMatches && colorMatches;
      });
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // QUANTITY
  // ============================================================

  void increaseQuantity() {
    final variant = selectedVariant;

    if (variant != null && _quantity < variant.stock) {
      _quantity++;
      notifyListeners();
      return;
    }

    if (variant == null) {
      _quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  // ============================================================
  // VALIDATE SELECTION
  // ============================================================

  String? validateSelection() {
    if (_product == null) {
      return 'Product not found.';
    }

    if (availableSizes.isNotEmpty && _selectedSize == null) {
      return 'Please select a size.';
    }

    if (availableColors.isNotEmpty && _selectedColor == null) {
      return 'Please select a color.';
    }

    final variant = selectedVariant;

    if (variant != null && (!variant.available || variant.stock <= 0)) {
      return 'Selected variant is out of stock.';
    }

    if (variant != null && _quantity > variant.stock) {
      return 'Only ${variant.stock} items are available.';
    }

    return null;
  }
}
