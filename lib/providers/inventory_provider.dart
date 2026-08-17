import 'package:flutter/material.dart';

import '../models/inventory_item_model.dart';
import '../repositories/inventory_repository.dart';

class InventoryProvider extends ChangeNotifier {
  List<InventoryItemModel> _products = [];

  List<InventoryItemModel> get products => _products;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  //----------------------------------------------------------
  // Load Inventory
  //----------------------------------------------------------

  Future<void> loadInventory() async {
    _isLoading = true;

    notifyListeners();

    try {
      _products = await InventoryRepository.getProducts();

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refresh() async {
    await loadInventory();
  }

  //----------------------------------------------------------
  // Search
  //----------------------------------------------------------

  List<InventoryItemModel> search(String keyword) {
    if (keyword.isEmpty) {
      return _products;
    }

    final lower = keyword.toLowerCase();

    return _products.where((product) {
      return product.name.toLowerCase().contains(lower) ||
          product.sku.toLowerCase().contains(lower);
    }).toList();
  }

  //----------------------------------------------------------
  // Summary
  //----------------------------------------------------------

  int get totalProducts => _products.length;

  int get inStock => _products.where((e) => e.stock > e.reorderLevel).length;

  int get lowStock =>
      _products.where((e) => e.stock > 0 && e.stock <= e.reorderLevel).length;

  int get outOfStock => _products.where((e) => e.stock == 0).length;

  double get inventoryValue {
    double value = 0;

    for (final product in _products) {
      value += product.price * product.stock;
    }

    return value;
  }
}
