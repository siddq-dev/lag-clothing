import 'dart:async';

import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> _items = [];

  bool _isLoading = false;
  bool _isSaving = false;

  String? _error;

  StreamSubscription<List<CartItemModel>>? _cartSubscription;

  double _discount = 0;

  // ============================================================
  // GETTERS
  // ============================================================

  List<CartItemModel> get items => List.unmodifiable(_items);

  bool get isLoading => _isLoading;

  bool get isSaving => _isSaving;

  String? get error => _error;

  bool get isEmpty => _items.isEmpty;

  // ============================================================
  // TOTALS
  // ============================================================

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + item.total);
  }

  double get shipping {
    return _items.isEmpty ? 0 : 100;
  }

  double get tax {
    return subtotal * 0.05;
  }

  double get discount => _discount;

  double get grandTotal {
    final total = subtotal + shipping + tax - discount;

    return total < 0 ? 0 : total;
  }

  // ============================================================
  // FETCH CART
  // ============================================================

  Future<void> fetchCart() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      _items = await CartRepository.getCartItems();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============================================================
  // LISTEN TO FIRESTORE
  // ============================================================

  void listenCart() {
    _cartSubscription?.cancel();

    _isLoading = true;
    _error = null;

    notifyListeners();

    _cartSubscription = CartRepository.streamCart().listen(
      (items) {
        _items = items;

        _isLoading = false;
        _error = null;

        notifyListeners();
      },
      onError: (Object error) {
        _error = error.toString();
        _isLoading = false;

        notifyListeners();
      },
    );
  }

  // ============================================================
  // ADD ITEM
  // ============================================================

  Future<bool> addItem(CartItemModel item) async {
    _isSaving = true;
    _error = null;

    notifyListeners();

    try {
      // --------------------------------------------------------
      // BASIC VALIDATION
      // --------------------------------------------------------

      if (item.productId.trim().isEmpty) {
        _error = 'Invalid product.';
        return false;
      }

      if (item.size.trim().isEmpty) {
        _error = 'Please select a size.';
        return false;
      }

      if (item.color.trim().isEmpty) {
        _error = 'Please select a color.';
        return false;
      }

      if (item.quantity <= 0) {
        _error = 'Quantity must be greater than zero.';
        return false;
      }

      // --------------------------------------------------------
      // STOCK VALIDATION
      // --------------------------------------------------------

      if (!item.isAvailable) {
        _error = 'Selected variant is no longer available.';
        return false;
      }

      if (item.availableStock != null && item.quantity > item.availableStock!) {
        _error =
            'Only ${item.availableStock} item(s) available for the selected size and color.';
        return false;
      }

      // --------------------------------------------------------
      // SAVE
      // --------------------------------------------------------

      await CartRepository.addToCart(item);

      return true;
    } catch (e) {
      _error = e.toString();

      return false;
    } finally {
      _isSaving = false;

      notifyListeners();
    }
  }

  // ============================================================
  // INCREASE QUANTITY
  // ============================================================

  Future<bool> increaseQuantity(CartItemModel item) async {
    // ----------------------------------------------------------
    // VARIANT UNAVAILABLE
    // ----------------------------------------------------------

    if (!item.isAvailable) {
      _error =
          'The selected ${item.size} / ${item.color} variant is unavailable.';

      notifyListeners();

      return false;
    }

    // ----------------------------------------------------------
    // STOCK CHECK
    // ----------------------------------------------------------

    if (item.availableStock != null && item.quantity >= item.availableStock!) {
      _error =
          'Only ${item.availableStock} item(s) available for this variant.';

      notifyListeners();

      return false;
    }

    final newQuantity = item.quantity + 1;

    return updateQuantity(itemId: item.id, quantity: newQuantity);
  }

  // ============================================================
  // DECREASE QUANTITY
  // ============================================================

  Future<bool> decreaseQuantity(CartItemModel item) async {
    final newQuantity = item.quantity - 1;

    if (newQuantity <= 0) {
      return removeItem(item.id);
    }

    return updateQuantity(itemId: item.id, quantity: newQuantity);
  }

  // ============================================================
  // UPDATE QUANTITY
  // ============================================================

  Future<bool> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final item = getItem(itemId);

      if (item == null) {
        _error = 'Cart item not found.';
        notifyListeners();

        return false;
      }

      // --------------------------------------------------------
      // REMOVE WHEN ZERO
      // --------------------------------------------------------

      if (quantity <= 0) {
        return removeItem(itemId);
      }

      // --------------------------------------------------------
      // AVAILABILITY CHECK
      // --------------------------------------------------------

      if (!item.isAvailable) {
        _error =
            'The selected ${item.size} / ${item.color} variant is unavailable.';

        notifyListeners();

        return false;
      }

      // --------------------------------------------------------
      // STOCK CHECK
      // --------------------------------------------------------

      if (item.availableStock != null && quantity > item.availableStock!) {
        _error =
            'Only ${item.availableStock} item(s) available for this variant.';

        notifyListeners();

        return false;
      }

      // --------------------------------------------------------
      // UPDATE FIRESTORE
      // --------------------------------------------------------

      await CartRepository.updateQuantity(itemId, quantity);

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  // ============================================================
  // REMOVE ITEM
  // ============================================================

  Future<bool> removeItem(String itemId) async {
    try {
      await CartRepository.removeItem(itemId);

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  // ============================================================
  // CLEAR CART
  // ============================================================

  Future<bool> clearCart() async {
    try {
      await CartRepository.clearCart();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  // ============================================================
  // DISCOUNT
  // ============================================================

  void applyDiscount(double value) {
    _discount = value < 0 ? 0 : value;

    notifyListeners();
  }

  void removeDiscount() {
    _discount = 0;

    notifyListeners();
  }

  // ============================================================
  // FIND ITEM
  // ============================================================

  CartItemModel? getItem(String itemId) {
    try {
      return _items.firstWhere((item) => item.id == itemId);
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // CLEAR ERROR
  // ============================================================

  void clearError() {
    if (_error == null) {
      return;
    }

    _error = null;

    notifyListeners();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _cartSubscription?.cancel();

    super.dispose();
  }
}
