import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';


class AdminProductFilterProvider extends ChangeNotifier {
  // =========================
  // Search
  // =========================

  String _search = "";

  String get search => _search;

  void updateSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void clearSearch() {
    _search = "";
    notifyListeners();
  }

  // =========================
  // Category
  // =========================

  String? _category;

  String? get category => _category;

  void updateCategory(String? value) {
    _category = value;
    notifyListeners();
  }

  // =========================
  // Brand
  // =========================

  String? _brand;

  String? get brand => _brand;

  void updateBrand(String? value) {
    _brand = value;
    notifyListeners();
  }

  // =========================
  // Status
  // =========================

  String? _status;

  String? get status => _status;

  void updateStatus(String? value) {
    _status = value;
    notifyListeners();
  }

  // =========================
  // Toggles
  // =========================

  bool _featured = false;
  bool _bestSeller = false;
  bool _newArrival = false;
  bool _lowStock = false;
  bool _outOfStock = false;

  bool get featured => _featured;
  bool get bestSeller => _bestSeller;
  bool get newArrival => _newArrival;
  bool get lowStock => _lowStock;
  bool get outOfStock => _outOfStock;

  void toggleFeatured(bool value) {
    _featured = value;
    notifyListeners();
  }

  void toggleBestSeller(bool value) {
    _bestSeller = value;
    notifyListeners();
  }

  void toggleNewArrival(bool value) {
    _newArrival = value;
    notifyListeners();
  }

  void toggleLowStock(bool value) {
    _lowStock = value;
    notifyListeners();
  }

  void toggleOutOfStock(bool value) {
    _outOfStock = value;
    notifyListeners();
  }

  // =========================
  // Sorting
  // =========================

  String _sortBy = "Newest";

  String get sortBy => _sortBy;

  void updateSort(String value) {
    _sortBy = value;
    notifyListeners();
  }

  // =========================
  // Reset
  // =========================

  void clearAll() {
    _search = "";
    _category = null;
    _brand = null;
    _status = null;

    _featured = false;
    _bestSeller = false;
    _newArrival = false;
    _lowStock = false;
    _outOfStock = false;

    _sortBy = "Newest";

    notifyListeners();
  }

List<ProductModel> apply(List<ProductModel> products) {
  List<ProductModel> list = List.from(products);

  // Search
  if (search.isNotEmpty) {
    final query = search.toLowerCase();

    list = list.where((product) {
    return product.name.toLowerCase().contains(query) ||
    product.brand.toLowerCase().contains(query) ||
    product.variants.any(
      (variant) =>
          variant.sku.toLowerCase().contains(query),
    );
    }).toList();
  }

  // Category
  if (category != null) {
    list = list.where((e) => e.category == category).toList();
  }

  // Brand
  if (brand != null) {
    list = list.where((e) => e.brand == brand).toList();
  }

  // Status
  if (status != null) {
    final active = status == "active";
    list = list.where((e) => e.status == active).toList();
  }

  // Featured
  if (featured) {
    list = list.where((e) => e.featured).toList();
  }

  // Best Seller
  if (bestSeller) {
    list = list.where((e) => e.bestSeller).toList();
  }

  // New Arrival
  if (newArrival) {
    list = list.where((e) => e.newArrival).toList();
  }

  // Sorting
  switch (sortBy) {
    case "Newest":
  list.sort((a, b) {
    final aTime =
        a.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

    final bTime =
        b.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

    return bTime.compareTo(aTime);
  });
  break;

case "Oldest":
  list.sort((a, b) {
    final aTime =
        a.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

    final bTime =
        b.createdAt?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);

    return aTime.compareTo(bTime);
  });
  break;
    case "Price ↑":
      list.sort((a, b) => a.price.compareTo(b.price));
      break;

    case "Price ↓":
      list.sort((a, b) => b.price.compareTo(a.price));
      break;

    case "Stock ↑":
      list.sort((a, b) => a.stock.compareTo(b.stock));
      break;

    case "Stock ↓":
      list.sort((a, b) => b.stock.compareTo(a.stock));
      break;

    case "Name A-Z":
      list.sort((a, b) => a.name.compareTo(b.name));
      break;

    case "Name Z-A":
      list.sort((a, b) => b.name.compareTo(a.name));
      break;

    case "Rating":
      list.sort((a, b) => b.rating.compareTo(a.rating));
      break;
  }

  return list;
}

}