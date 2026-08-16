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

  // ============================================================
  // GETTERS
  // ============================================================

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
        _product = null;
        _error = 'Product not found.';
      } else {
        _product = product;

        _initializeSelections(product);
      }
    } catch (e) {
      _product = null;
      _error = e.toString();
    } finally {
      _loading = false;

      notifyListeners();
    }
  }

  // ============================================================
  // AVAILABLE VARIANTS
  // ============================================================

  List<ProductVariantModel> get _availableVariants {
    if (_product == null) {
      return [];
    }

    return _product!.variants.where((variant) {
      return variant.available && variant.stock > 0;
    }).toList();
  }

  // ============================================================
  // INITIALIZE SELECTIONS
  // ============================================================

  void _initializeSelections(ProductModel product) {
    _selectedSize = null;
    _selectedColor = null;
    _quantity = 1;

    final variants = product.variants.where((variant) {
      return variant.available && variant.stock > 0;
    }).toList();

    if (variants.isEmpty) {
      return;
    }

    final sizes = variants
        .map((variant) => variant.size.trim())
        .where((size) => size.isNotEmpty)
        .toSet()
        .toList();

    final colors = variants
        .map((variant) => variant.color.trim())
        .where((color) => color.isNotEmpty)
        .toSet()
        .toList();

    // If there is only one possible size, select it automatically.
    if (sizes.length == 1) {
      _selectedSize = sizes.first;
    }

    // If there is only one possible color, select it automatically.
    if (colors.length == 1) {
      _selectedColor = colors.first;
    }

    // If both dimensions have been automatically selected,
    // make sure the combination actually exists.
    final variant = selectedVariant;

    if (variant == null) {
      if (sizes.length == 1) {
        _selectedSize = null;
      }

      if (colors.length == 1) {
        _selectedColor = null;
      }
    }
  }

  // ============================================================
  // AVAILABLE SIZES
  // ============================================================

  List<String> get availableSizes {
    return _availableVariants
        .map((variant) => variant.size.trim())
        .where((size) => size.isNotEmpty)
        .toSet()
        .toList();
  }

  // ============================================================
  // AVAILABLE COLORS
  // ============================================================

  List<String> get availableColors {
    return _availableVariants
        .map((variant) => variant.color.trim())
        .where((color) => color.isNotEmpty)
        .toSet()
        .toList();
  }

  // ============================================================
  // SELECT SIZE
  // ============================================================

  void selectSize(String size) {
    final normalizedSize = size.trim();

    if (normalizedSize.isEmpty) {
      return;
    }

    _selectedSize = normalizedSize;

    // Reset quantity whenever the variant changes.
    _quantity = 1;

    notifyListeners();
  }

  // ============================================================
  // SELECT COLOR
  // ============================================================

  void selectColor(String color) {
    final normalizedColor = color.trim();

    if (normalizedColor.isEmpty) {
      return;
    }

    _selectedColor = normalizedColor;

    // Reset quantity whenever the variant changes.
    _quantity = 1;

    notifyListeners();
  }

  // ============================================================
  // SELECTED VARIANT
  // ============================================================

  ProductVariantModel? get selectedVariant {
    if (_product == null) {
      return null;
    }

    final selectedSize = _selectedSize?.trim();
    final selectedColor = _selectedColor?.trim();

    final variants = _product!.variants.where((variant) {
      if (!variant.available || variant.stock <= 0) {
        return false;
      }

      final sizeMatches =
          selectedSize == null ||
          selectedSize.isEmpty ||
          variant.size.trim() == selectedSize;

      final colorMatches =
          selectedColor == null ||
          selectedColor.isEmpty ||
          variant.color.trim() == selectedColor;

      return sizeMatches && colorMatches;
    }).toList();

    if (variants.isEmpty) {
      return null;
    }

    // If both size and color are required, only return
    // the exact combination.
    if (availableSizes.isNotEmpty &&
        availableColors.isNotEmpty &&
        (selectedSize == null ||
            selectedSize.isEmpty ||
            selectedColor == null ||
            selectedColor.isEmpty)) {
      return null;
    }

    return variants.first;
  }

  // ============================================================
  // SELECTED VARIANT STOCK
  // ============================================================

  int get selectedVariantStock {
    return selectedVariant?.stock ?? 0;
  }

  // ============================================================
  // QUANTITY
  // ============================================================

  void increaseQuantity() {
    final variant = selectedVariant;

    if (variant == null) {
      return;
    }

    if (_quantity < variant.stock) {
      _quantity++;

      notifyListeners();
    }
  }

  void decreaseQuantity() {
    if (_quantity <= 1) {
      return;
    }

    _quantity--;

    notifyListeners();
  }

  void setQuantity(int value) {
    final variant = selectedVariant;

    if (value < 1) {
      _quantity = 1;
    } else if (variant != null && value > variant.stock) {
      _quantity = variant.stock;
    } else {
      _quantity = value;
    }

    notifyListeners();
  }

  // ============================================================
  // VALIDATE SELECTION
  // ============================================================

  String? validateSelection() {
    if (_product == null) {
      return 'Product not found.';
    }

    // ----------------------------------------------------------
    // SIZE REQUIRED
    // ----------------------------------------------------------

    if (availableSizes.isNotEmpty) {
      if (_selectedSize == null || _selectedSize!.trim().isEmpty) {
        return 'Please select a size.';
      }
    }

    // ----------------------------------------------------------
    // COLOR REQUIRED
    // ----------------------------------------------------------

    if (availableColors.isNotEmpty) {
      if (_selectedColor == null || _selectedColor!.trim().isEmpty) {
        return 'Please select a color.';
      }
    }

    // ----------------------------------------------------------
    // EXACT VARIANT
    // ----------------------------------------------------------

    final variant = selectedVariant;

    if (variant == null) {
      return 'The selected size and color combination is unavailable.';
    }

    // ----------------------------------------------------------
    // AVAILABILITY
    // ----------------------------------------------------------

    if (!variant.available || variant.stock <= 0) {
      return 'Selected variant is out of stock.';
    }

    // ----------------------------------------------------------
    // QUANTITY
    // ----------------------------------------------------------

    if (_quantity < 1) {
      return 'Quantity must be at least 1.';
    }

    if (_quantity > variant.stock) {
      return 'Only ${variant.stock} item(s) available for this size and color.';
    }

    return null;
  }
}
