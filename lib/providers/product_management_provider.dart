import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lag_clothing/repositories/product_repository.dart';

import '../../../../models/product_model.dart';

import '../repositories/product_management_repository.dart';

import '../../../../models/product_image_model.dart';
import '../../../../models/product_variant_model.dart';

import '../models/product_form_model.dart';
import '../../../../models/product_seo_model.dart';


import '../services/stock_update_service.dart';

class ProductManagementProvider extends ChangeNotifier {
  //==========================================================
  // Product Form
  //==========================================================

  ProductFormModel _form = ProductFormModel();

  ProductFormModel get form => _form;

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
  notifyListeners();
}

  //--------------------------------------------------
  // Products
  //--------------------------------------------------

  List<ProductModel> _products = [];

  List<ProductModel> get products =>
      _products;


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
// Variants
//======================================================

void addVariant(ProductVariantModel variant) {
  _form.variants.add(variant);
  notifyListeners();
}

void removeVariant(ProductVariantModel variant) {
  _form.variants.remove(variant);
  notifyListeners();
}



//======================================================
// Update Variant
//======================================================

void updateVariantSize(
  ProductVariantModel variant,
  String value,
) {
  final index = _form.variants.indexOf(variant);

  if (index == -1) return;

  _form.variants[index] = variant.copyWith(
    size: value,
  );

  notifyListeners();
}

void updateVariantColor(
  ProductVariantModel variant,
  String value,
) {
  final index = _form.variants.indexOf(variant);

  if (index == -1) return;

  _form.variants[index] = variant.copyWith(
    color: value,
  );

  notifyListeners();
}

void updateVariantStock(
  ProductVariantModel variant,
  String value,
) {
  final index = _form.variants.indexOf(variant);

  if (index == -1) return;

  _form.variants[index] = variant.copyWith(
    stock: int.tryParse(value) ?? 0,
  );

  notifyListeners();
}

void updateVariantPrice(
  ProductVariantModel variant,
  String value,
) {
  final index = _form.variants.indexOf(variant);

  if (index == -1) return;

  _form.variants[index] = variant.copyWith(
    additionalPrice:
        double.tryParse(value) ?? 0,
  );

  notifyListeners();
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

    ProductManagementRepository
        .streamRecentProducts()
        .listen(
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
    final stats =
        await ProductManagementRepository
            .getStatistics();

    totalProducts = stats["total"] ?? 0;

    activeProducts = stats["active"] ?? 0;

    inactiveProducts = stats["inactive"] ?? 0;

    notifyListeners();
  }

  //--------------------------------------------------
  // Delete Product
  //--------------------------------------------------

  Future<void> deleteProduct(
    String productId,
  ) async {
    await ProductManagementRepository
        .deleteProduct(productId);
  }



Future<void> loadProduct(String productId) async {
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    final product =
        await ProductRepository.getProduct(productId);

    if (product == null) {
      throw Exception("Product not found.");
    }

    _editingProduct = product;

    // Basic Information
    _form.name = product.name;
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
    _form.images = List<ProductImageModel>.from(
      product.images,
    );

    // Variants
    _form.variants = List<ProductVariantModel>.from(
      product.variants,
    );

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

  //--------------------------------------------------
  // Refresh
  //--------------------------------------------------

  Future<void> refresh() async {
    await loadStatistics();
  }


Future<void> publishProduct() async {
  try {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Validation
    if (_form.name.trim().isEmpty) {
      throw Exception("Product name is required.");
    }

    if (_form.category.trim().isEmpty) {
      throw Exception("Category is required.");
    }

    // if (_form.images.isEmpty) {
    //   throw Exception("Please upload at least one product image.");
    // }

    if (_form.price <= 0) {
      throw Exception("Price must be greater than zero.");
    }

    final product = ProductModel(
      id: "",
      name: _form.name,
      description: _form.description,
      brand: _form.brand,
      category: _form.category,
      subCategory: _form.subCategory,
      price: _form.price,
      salePrice: _form.salePrice,
      stock: _form.stock,
      rating: 0,
      reviewCount: 0,
      featured: _form.featured,
      bestSeller: _form.bestSeller,
      newArrival: _form.newArrival,
      status: _form.status,
      images: _form.images,
      variants: _form.variants,
      seo: _form.seo,
      createdAt: null,
      updatedAt: null,
    );

 ProductModel savedProduct;

if (isEditing) {
  savedProduct = _editingProduct!.copyWith(
    name: _form.name,
    description: _form.description,
    brand: _form.brand,
    category: _form.category,
    subCategory: _form.subCategory,
    price: _form.price,
    salePrice: _form.salePrice,
    stock: _form.stock,
    featured: _form.featured,
    bestSeller: _form.bestSeller,
    newArrival: _form.newArrival,
    status: _form.status,
    images: _form.images,
    variants: _form.variants,
    seo: _form.seo,
    updatedAt: Timestamp.now(),
  );

  await ProductManagementRepository.updateProduct(
    savedProduct,
  );
} else {
  savedProduct =
      await ProductManagementRepository.createProduct(
    product,
  );

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

   await loadStatistics();

listenProducts();

resetForm();
  } catch (e) {
    _error = e.toString();
  }

  _isLoading = false;
  notifyListeners();

if (isEditing) {
  // UPDATE PRODUCT
} else {
  // CREATE PRODUCT
}

}
}