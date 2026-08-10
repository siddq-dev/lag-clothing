import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:lag_clothing/repositories/product_repository.dart';

import '../../../../models/product_model.dart';
import 'package:lag_clothing/models/product_color_variant_model.dart';

import '../repositories/product_management_repository.dart';

import '../../../../models/product_image_model.dart';
import '../../../../models/product_variant_model.dart';

import '../models/product_form_model.dart';
import '../../../../models/product_seo_model.dart';

import '../services/stock_update_service.dart';

class ProductManagementProvider extends ChangeNotifier {
  //==========================================================
  // SAME STOCK FOR ALL
  //==========================================================

  bool _sameStockForAll = false;

  bool get sameStockForAll => _sameStockForAll;

  String _commonStock = "";

  String get commonStock => _commonStock;

  void toggleSameStock(bool value) {
    _sameStockForAll = value;

    if (!value) {
      _commonStock = "";
    }

    notifyListeners();
  }

  void updateCommonStock(String value) {
    _commonStock = value;

    final stock = int.tryParse(value) ?? 0;

    for (int i = 0; i < _colorVariants.length; i++) {
      final group = _colorVariants[i];

      final updatedVariants = group.variants
          .map(
            (variant) => variant.copyWith(stock: stock, available: stock > 0),
          )
          .toList();

      _colorVariants[i] = group.copyWith(variants: updatedVariants);
    }

    _recalculateVariants();

    notifyListeners();
  }

  //==========================================================
  // PRODUCT FORM
  //==========================================================

  ProductFormModel _form = ProductFormModel();

  ProductFormModel get form => _form;

  //==========================================================
  // COLOR VARIANTS
  //==========================================================

  final List<ProductColorVariantModel> _colorVariants = [];

  List<ProductColorVariantModel> get colorVariants => _colorVariants;

  //==========================================================
  // EDITING
  //==========================================================

  ProductModel? _editingProduct;

  bool get isEditing => _editingProduct != null;

  ProductModel? get editingProduct => _editingProduct;

  //==========================================================
  // BASIC INFORMATION
  //==========================================================

  void updateName(String value) {
    _form.name = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    _form.description = value;
    notifyListeners();
  }

  void updateBrand(String value) {
    _form.brand = value;
    notifyListeners();
  }

  void updateCategory(String value) {
    _form.category = value;
    notifyListeners();
  }

  void updateSubCategory(String value) {
    _form.subCategory = value;
    notifyListeners();
  }

  //==========================================================
  // PRICING
  //==========================================================

  void updatePrice(String value) {
    _form.price = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateSalePrice(String value) {
    _form.salePrice = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  //==========================================================
  // INVENTORY
  //==========================================================

  void updateStock(String value) {
    _form.stock = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  int get totalStock {
    return _form.variants.fold(0, (sum, variant) => sum + variant.stock);
  }

  //==========================================================
  // FLAGS
  //==========================================================

  void updateFeatured(bool value) {
    _form.featured = value;
    notifyListeners();
  }

  void updateBestSeller(bool value) {
    _form.bestSeller = value;
    notifyListeners();
  }

  void updateNewArrival(bool value) {
    _form.newArrival = value;
    notifyListeners();
  }

  void updateStatus(bool value) {
    _form.status = value;
    notifyListeners();
  }

  //==========================================================
  // SEO
  //==========================================================

  void updateSeoTitle(String value) {
    _form.seo = ProductSeoModel(
      seoTitle: value,
      metaDescription: _form.seo.metaDescription,
      slug: _form.seo.slug,
      keywords: _form.seo.keywords,
      hashtags: _form.seo.hashtags,
      searchTags: _form.seo.searchTags,
      openGraphImage: _form.seo.openGraphImage,
    );

    notifyListeners();
  }

  void updateMetaDescription(String value) {
    _form.seo = ProductSeoModel(
      seoTitle: _form.seo.seoTitle,
      metaDescription: value,
      slug: _form.seo.slug,
      keywords: _form.seo.keywords,
      hashtags: _form.seo.hashtags,
      searchTags: _form.seo.searchTags,
      openGraphImage: _form.seo.openGraphImage,
    );

    notifyListeners();
  }

  void updateSlug(String value) {
    _form.seo = ProductSeoModel(
      seoTitle: _form.seo.seoTitle,
      metaDescription: _form.seo.metaDescription,
      slug: value,
      keywords: _form.seo.keywords,
      hashtags: _form.seo.hashtags,
      searchTags: _form.seo.searchTags,
      openGraphImage: _form.seo.openGraphImage,
    );

    notifyListeners();
  }

  //==========================================================
  // IMAGES
  //==========================================================

  static const int maxProductImages = 5;
  static const int minProductImages = 1;

  /// Add an uploaded image to the current product form.
  ///
  /// The actual Firebase Storage upload happens in
  /// ImageUploadSection.
  void addImage(ProductImageModel image) {
    if (_form.images.length >= maxProductImages) {
      _error = "A maximum of $maxProductImages product images is allowed.";
      notifyListeners();
      return;
    }

    final imageId = image.id.trim().isEmpty
        ? DateTime.now().microsecondsSinceEpoch.toString()
        : image.id;

    final isFirstImage = _form.images.isEmpty;

    final newImage = image.copyWith(
      id: imageId,
      isPrimary: isFirstImage ? true : image.isPrimary,
    );

    _form.images.add(newImage);

    _error = null;

    debugPrint("Product image added: ${newImage.id}");

    debugPrint("Image URL: ${newImage.imageUrl}");

    debugPrint("Total product images: ${_form.images.length}");

    notifyListeners();
  }

  /// Remove an image from the current form.
  ///
  /// Firebase Storage deletion is intentionally not performed
  /// here because the provider only manages product state.
  void removeImage(ProductImageModel image) {
    _form.images.removeWhere((item) => item.id == image.id);

    // If the removed image was primary,
    // make the first remaining image primary.
    if (_form.images.isNotEmpty) {
      bool hasPrimary = _form.images.any((image) => image.isPrimary);

      if (!hasPrimary) {
        _form.images[0] = _form.images[0].copyWith(isPrimary: true);
      }
    }

    _error = null;

    debugPrint("Product image removed: ${image.id}");

    debugPrint("Remaining images: ${_form.images.length}");

    notifyListeners();
  }

  /// Makes a selected image the primary product image.
  void setPrimaryImage(ProductImageModel image) {
    _form.images = _form.images.map((item) {
      return item.copyWith(isPrimary: item.id == image.id);
    }).toList();

    notifyListeners();
  }

  //==========================================================
  // RESET FORM
  //==========================================================

  void resetForm() {
    _editingProduct = null;

    _form = ProductFormModel();

    _colorVariants.clear();

    _commonStock = "";

    _sameStockForAll = false;

    _error = null;

    notifyListeners();
  }

  //==========================================================
  // PRODUCTS
  //==========================================================

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  //==========================================================
  // AVAILABLE SIZES
  //==========================================================

  final List<String> availableSizes = ["XS", "S", "M", "L", "XL", "XXL", "3XL"];

  //==========================================================
  // RECALCULATE VARIANTS
  //==========================================================

  void _recalculateVariants() {
    _form.variants.clear();

    for (final group in _colorVariants) {
      _form.variants.addAll(group.variants);
    }

    _form.stock = totalStock;
  }

  //==========================================================
  // STATISTICS
  //==========================================================

  int totalProducts = 0;
  int activeProducts = 0;
  int inactiveProducts = 0;

  //==========================================================
  // LOADING
  //==========================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //==========================================================
  // ERROR
  //==========================================================

  String? _error;

  String? get error => _error;

  //==========================================================
  // LISTEN PRODUCTS
  //==========================================================

  void listenProducts() {
    _isLoading = true;
    _error = null;

    notifyListeners();

    ProductManagementRepository.streamRecentProducts().listen(
      (products) {
        _products = products;

        _isLoading = false;

        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();

        _isLoading = false;

        notifyListeners();
      },
    );
  }

  //==========================================================
  // DASHBOARD STATISTICS
  //==========================================================

  Future<void> loadStatistics() async {
    try {
      final stats = await ProductManagementRepository.getStatistics();

      totalProducts = stats["total"] ?? 0;

      activeProducts = stats["active"] ?? 0;

      inactiveProducts = stats["inactive"] ?? 0;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  //==========================================================
  // DELETE PRODUCT
  //==========================================================

  Future<void> deleteProduct(String productId) async {
    try {
      await ProductManagementRepository.deleteProduct(productId);

      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  //==========================================================
  // LOAD PRODUCT FOR EDITING
  //==========================================================

  Future<void> loadProduct(String productId) async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final product = await ProductRepository.getProduct(productId);

      if (product == null) {
        throw Exception("Product not found.");
      }

      _editingProduct = product;

      //======================================================
      // BASIC INFORMATION
      //======================================================

      _form.name = product.name;
      _form.description = product.description;
      _form.brand = product.brand;
      _form.category = product.category;
      _form.subCategory = product.subCategory;

      //======================================================
      // PRICING
      //======================================================

      _form.price = product.price;
      _form.salePrice = product.salePrice;

      //======================================================
      // INVENTORY
      //======================================================

      _form.stock = product.stock;

      //======================================================
      // FLAGS
      //======================================================

      _form.featured = product.featured;
      _form.bestSeller = product.bestSeller;
      _form.newArrival = product.newArrival;
      _form.status = product.status;

      //======================================================
      // IMAGES
      //
      // IMPORTANT:
      // Existing Firestore images are copied into the form.
      // Therefore Edit Product displays the existing images.
      //======================================================

      _form.images = List<ProductImageModel>.from(product.images);

      debugPrint("======== PRODUCT IMAGES LOADED ========");

      debugPrint("Product ID: ${product.id}");

      debugPrint("Image count: ${_form.images.length}");

      for (final image in _form.images) {
        debugPrint("Image ID: ${image.id}");

        debugPrint("Image URL: ${image.imageUrl}");

        debugPrint("Primary: ${image.isPrimary}");
      }

      //======================================================
      // VARIANTS
      //======================================================

      _form.variants = List<ProductVariantModel>.from(product.variants);

      //======================================================
      // BUILD COLOR GROUPS
      //======================================================

      _colorVariants.clear();

      for (final variant in product.variants) {
        final index = _colorVariants.indexWhere(
          (group) => group.color == variant.color,
        );

        if (index == -1) {
          _colorVariants.add(
            ProductColorVariantModel(color: variant.color, variants: [variant]),
          );
        } else {
          final group = _colorVariants[index];

          _colorVariants[index] = group.copyWith(
            variants: [...group.variants, variant],
          );
        }
      }

      //======================================================
      // SEO
      //======================================================

      _form.seo = product.seo;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  //==========================================================
  // CLEAR EDITING
  //==========================================================

  void clearEditing() {
    _editingProduct = null;
    resetForm();
  }

  //==========================================================
  // COLOR VARIANTS
  //==========================================================

  void addColorVariant() {
    _colorVariants.add(ProductColorVariantModel(color: "", variants: []));

    notifyListeners();
  }

  void removeColorVariant(ProductColorVariantModel color) {
    _colorVariants.remove(color);

    _recalculateVariants();

    notifyListeners();
  }

  void updateColorName(ProductColorVariantModel group, String color) {
    final index = _colorVariants.indexOf(group);

    if (index == -1) return;

    _colorVariants[index] = _colorVariants[index].copyWith(color: color);

    _recalculateVariants();

    notifyListeners();
  }

  //==========================================================
  // TOGGLE SIZE
  //==========================================================

  void toggleSizeForColor(ProductColorVariantModel group, String size) {
    final groupIndex = _colorVariants.indexOf(group);

    debugPrint("Group Index = $groupIndex");

    debugPrint("Color = ${group.color}");

    debugPrint("Color Variants Count = ${_colorVariants.length}");

    if (groupIndex == -1) return;

    final variants = List<ProductVariantModel>.from(group.variants);

    final existingIndex = variants.indexWhere((v) => v.size == size);

    if (existingIndex != -1) {
      variants.removeAt(existingIndex);
    } else {
      variants.add(
        ProductVariantModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          size: size,
          color: group.color,
          sku: "",
          stock: 0,
          available: true,
          additionalPrice: 0,
        ),
      );
    }

    _colorVariants[groupIndex] = group.copyWith(variants: variants);

    _recalculateVariants();

    debugPrint("Form Variants = ${_form.variants.length}");

    notifyListeners();
  }

  //==========================================================
  // UPDATE STOCK FOR COLOR/SIZE
  //==========================================================

  void updateStockForColorSize(
    ProductColorVariantModel group,
    ProductVariantModel variant,
    String value,
  ) {
    final stock = int.tryParse(value) ?? 0;

    final groupIndex = _colorVariants.indexOf(group);

    if (groupIndex == -1) return;

    final variants = List<ProductVariantModel>.from(group.variants);

    final variantIndex = variants.indexOf(variant);

    if (variantIndex == -1) return;

    variants[variantIndex] = variant.copyWith(
      stock: stock,
      available: stock > 0,
    );

    _colorVariants[groupIndex] = group.copyWith(variants: variants);

    _recalculateVariants();

    notifyListeners();
  }

  //==========================================================
  // UPDATE SKU
  //==========================================================

  void updateSkuForColorSize(
    ProductColorVariantModel group,
    ProductVariantModel variant,
    String sku,
  ) {
    final groupIndex = _colorVariants.indexOf(group);

    if (groupIndex == -1) return;

    final variants = List<ProductVariantModel>.from(group.variants);

    final variantIndex = variants.indexOf(variant);

    if (variantIndex == -1) return;

    variants[variantIndex] = variant.copyWith(sku: sku);

    _colorVariants[groupIndex] = group.copyWith(variants: variants);

    _recalculateVariants();

    notifyListeners();
  }

  //==========================================================
  // REFRESH
  //==========================================================

  Future<void> refresh() async {
    await loadStatistics();
  }

  //==========================================================
  // PUBLISH / UPDATE PRODUCT
  //==========================================================

  Future<void> publishProduct() async {
    _recalculateVariants();

    _form.stock = totalStock;

    debugPrint("========= PUBLISH PRODUCT =========");

    debugPrint("Product name: ${_form.name}");

    debugPrint("Image count: ${_form.images.length}");

    for (final image in _form.images) {
      debugPrint("Image ID: ${image.id}");

      debugPrint("Image URL: ${image.imageUrl}");

      debugPrint("Primary: ${image.isPrimary}");
    }

    debugPrint("Total Stock = $totalStock");

    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      //======================================================
      // VALIDATION
      //======================================================

      if (_form.name.trim().isEmpty) {
        throw Exception("Product name is required.");
      }

      if (_form.category.trim().isEmpty) {
        throw Exception("Category is required.");
      }

      if (_form.price <= 0) {
        throw Exception("Price must be greater than zero.");
      }

      if (_form.images.length < minProductImages) {
        throw Exception("At least one product image is required.");
      }

      if (_form.images.length > maxProductImages) {
        throw Exception(
          "A maximum of $maxProductImages product images is allowed.",
        );
      }

      //======================================================
      // MAKE SURE THERE IS ONE PRIMARY IMAGE
      //======================================================

      if (_form.images.isNotEmpty) {
        final primaryCount = _form.images
            .where((image) => image.isPrimary)
            .length;

        if (primaryCount == 0) {
          _form.images[0] = _form.images[0].copyWith(isPrimary: true);
        }
      }

      //======================================================
      // CREATE PRODUCT MODEL
      //======================================================

      final product = ProductModel(
        id: "",
        name: _form.name,
        description: _form.description,
        brand: _form.brand,
        category: _form.category,
        subCategory: _form.subCategory,
        price: _form.price,
        salePrice: _form.salePrice,
        stock: totalStock,
        rating: 0,
        reviewCount: 0,
        featured: _form.featured,
        bestSeller: _form.bestSeller,
        newArrival: _form.newArrival,
        status: _form.status,
        images: List<ProductImageModel>.from(_form.images),
        variants: _form.variants.map((e) => e.copyWith()).toList(),
        seo: _form.seo,
        createdAt: null,
        updatedAt: null,
      );

      ProductModel savedProduct;

      //======================================================
      // UPDATE EXISTING PRODUCT
      //======================================================

      if (isEditing) {
        savedProduct = _editingProduct!.copyWith(
          name: _form.name,
          description: _form.description,
          brand: _form.brand,
          category: _form.category,
          subCategory: _form.subCategory,
          price: _form.price,
          salePrice: _form.salePrice,
          stock: totalStock,
          featured: _form.featured,
          bestSeller: _form.bestSeller,
          newArrival: _form.newArrival,
          status: _form.status,

          // IMPORTANT:
          // Save current images to Firestore.
          images: List<ProductImageModel>.from(_form.images),

          variants: List<ProductVariantModel>.from(_form.variants),

          seo: _form.seo,
          updatedAt: Timestamp.now(),
        );

        await ProductManagementRepository.updateProduct(savedProduct);
      }
      //======================================================
      // CREATE NEW PRODUCT
      //======================================================
      else {
        savedProduct = await ProductManagementRepository.createProduct(product);

        await StockUpdateService.logStockIn(
          productId: savedProduct.id,
          productName: savedProduct.name,
          quantity: savedProduct.stock,
          previousStock: 0,
          newStock: savedProduct.stock,
          reference: "Product Created",
          performedBy: "Super Admin",
        );
      }

      //======================================================
      // REFRESH DASHBOARD
      //======================================================

      await loadStatistics();

      listenProducts();

      debugPrint("Product saved successfully.");

      debugPrint("Saved product ID: ${savedProduct.id}");

      debugPrint("Saved image count: ${savedProduct.images.length}");
    } catch (e) {
      _error = e.toString();

      debugPrint("PUBLISH PRODUCT ERROR: $_error");
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}
