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
  // Product Form
  //==========================================================

  ProductFormModel _form = ProductFormModel();

  ProductFormModel get form => _form;

  ///--------------------------------------------------
  // Color Variants
  //--------------------------------------------------

  final List<ProductColorVariantModel> _colorVariants = [];

  List<ProductColorVariantModel> get colorVariants => _colorVariants;

  //==========================================================
  // Basic Information
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

  //--------------------------------------------------
  // Editing
  //--------------------------------------------------

  ProductModel? _editingProduct;

  bool get isEditing => _editingProduct != null;

  ProductModel? get editingProduct => _editingProduct;

  //==========================================================
  // Pricing
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
  // Inventory
  //==========================================================

  void updateStock(String value) {
    _form.stock = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  int get totalStock {
    return _form.variants.fold(0, (sum, variant) => sum + variant.stock);
  }

  //==========================================================
  // Flags
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
  // Reset Form
  //==========================================================

  void resetForm() {
    _editingProduct = null;

    _form = ProductFormModel();

    _colorVariants.clear();

    _commonStock = "";

    _sameStockForAll = false;

    notifyListeners();
  }

  //--------------------------------------------------
  // Products
  //--------------------------------------------------

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  //======================================================
  // Images
  //======================================================

  void addImage(ProductImageModel image) {
    _form.images.add(image);
    notifyListeners();
  }

  void removeImage(ProductImageModel image) {
    _form.images.remove(image);
    notifyListeners();
  }

  //======================================================
  // Update Variant
  //======================================================

  //--------------------------------------------------
  // product Sizes
  //---------------------------------------------------

  //--------------------------------------------------
  // Available Sizes
  //--------------------------------------------------

  final List<String> availableSizes = ["XS", "S", "M", "L", "XL", "XXL", "3XL"];

  void _recalculateVariants() {
    _form.variants.clear();

    for (final group in _colorVariants) {
      _form.variants.addAll(group.variants);
    }

    _form.stock = totalStock;
  }
  //--------------------------------------------------
  // Statistics
  //--------------------------------------------------

  int totalProducts = 0;
  int activeProducts = 0;
  int inactiveProducts = 0;

  //--------------------------------------------------
  // Loading
  //--------------------------------------------------

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //--------------------------------------------------
  // Error
  //--------------------------------------------------

  String? _error;

  String? get error => _error;

  //--------------------------------------------------
  // Listen Products
  //--------------------------------------------------

  void listenProducts() {
    _isLoading = true;

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

  //--------------------------------------------------
  // Dashboard Statistics
  //--------------------------------------------------

  Future<void> loadStatistics() async {
    final stats = await ProductManagementRepository.getStatistics();

    totalProducts = stats["total"] ?? 0;

    activeProducts = stats["active"] ?? 0;

    inactiveProducts = stats["inactive"] ?? 0;

    notifyListeners();
  }

  //--------------------------------------------------
  // Delete Product
  //--------------------------------------------------

  Future<void> deleteProduct(String productId) async {
    await ProductManagementRepository.deleteProduct(productId);
  }

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

      // Basic Information
      _form.name = product.name;
      debugPrint("======== LOADED PRODUCT ========");
      debugPrint(_form.name);
      debugPrint(_form.description);
      debugPrint(_form.brand);
      debugPrint(_form.category);
      debugPrint(_form.subCategory);
      debugPrint(_form.price.toString());
      debugPrint(_form.salePrice.toString());
      debugPrint(_form.stock.toString());
      debugPrint(_form.featured.toString());
      debugPrint(_form.bestSeller.toString());
      debugPrint(_form.newArrival.toString());
      debugPrint(_form.status.toString());
      debugPrint(_form.images.length.toString());
      debugPrint(_form.variants.length.toString());
      _form.description = product.description;
      _form.brand = product.brand;
      _form.category = product.category;
      _form.subCategory = product.subCategory;

      // Pricing
      _form.price = product.price;
      _form.salePrice = product.salePrice;

      // Inventory
      _form.stock = product.stock;

      // Flags
      _form.featured = product.featured;
      _form.bestSeller = product.bestSeller;
      _form.newArrival = product.newArrival;
      _form.status = product.status;

      // Images
      _form.images = List<ProductImageModel>.from(product.images);

      _form.variants = List<ProductVariantModel>.from(product.variants);

      // Build Color Groups
      _colorVariants.clear();

      for (final variant in product.variants) {
        final index = _colorVariants.indexWhere(
          (g) => g.color == variant.color,
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

      // SEO
      _form.seo = product.seo;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearEditing() {
    _editingProduct = null;
    resetForm();
  }

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
  //--------------------------------------------------
  // Refresh
  //--------------------------------------------------

  Future<void> refresh() async {
    await loadStatistics();
  }

  Future<void> publishProduct() async {
    _recalculateVariants();
    _form.stock = totalStock;

    debugPrint("========= VARIANTS =========");

    for (final v in _form.variants) {
      debugPrint("${v.color} ${v.size} | Stock: ${v.stock} | SKU: ${v.sku}");
    }

    debugPrint("Total Stock = $totalStock");

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      //--------------------------------------------------
      // Validation
      //--------------------------------------------------

      if (_form.name.trim().isEmpty) {
        throw Exception("Product name is required.");
      }

      if (_form.category.trim().isEmpty) {
        throw Exception("Category is required.");
      }

      if (_form.price <= 0) {
        throw Exception("Price must be greater than zero.");
      }

      if (_form.images.isEmpty) {
        throw Exception("At least one product image is required.");
      }

      if (_form.images.length > 5) {
        throw Exception("A maximum of 5 product images is allowed.");
      }

      //--------------------------------------------------
      // Create Product Model
      //--------------------------------------------------

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
        images: _form.images,
        variants: _form.variants.map((e) => e.copyWith()).toList(),
        seo: _form.seo,
        createdAt: null,
        updatedAt: null,
      );

      ProductModel savedProduct;

      //--------------------------------------------------
      // UPDATE PRODUCT
      //--------------------------------------------------

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
          images: _form.images,
          variants: List<ProductVariantModel>.from(_form.variants),
          seo: _form.seo,
          updatedAt: Timestamp.now(),
        );

        await ProductManagementRepository.updateProduct(savedProduct);
      }
      //--------------------------------------------------
      // CREATE PRODUCT
      //--------------------------------------------------
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

      //--------------------------------------------------
      // Refresh Dashboard
      //--------------------------------------------------

      await loadStatistics();
      listenProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
