import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> _items = [];

  bool _isLoading = false;

  String? _error;

  List<CartItemModel> get items => _items;

  bool get isLoading => _isLoading;

  String? get error => _error;

  //----------------------------------------------------------
  // Totals
  //----------------------------------------------------------

  double get subtotal =>
      _items.fold(
        0,
        (sum, item) => sum + item.total,
      );

  double get shipping =>
      _items.isEmpty ? 0 : 100;

  double get tax => subtotal * 0.05;

  double _discount = 0;

double get discount => _discount;

  double get grandTotal =>
      subtotal + shipping + tax - discount;

      void applyDiscount(double value) {
  _discount = value;
  notifyListeners();
}

void removeDiscount() {
  _discount = 0;
  notifyListeners();
}

  //----------------------------------------------------------
  // Fetch Cart
  //----------------------------------------------------------

  Future<void> fetchCart() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      _items =
          await CartRepository.getCartItems();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  //----------------------------------------------------------
  // Listen Cart
  //----------------------------------------------------------

  void listenCart() {
    _isLoading = true;

    notifyListeners();

    CartRepository.streamCart().listen(
      (items) {
        _items = items;

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

  //----------------------------------------------------------
  // Add Item
  //----------------------------------------------------------

  Future<void> addItem(
    CartItemModel item,
  ) async {
    await CartRepository.addToCart(item);
  }

  //----------------------------------------------------------
  // Increase Quantity
  //----------------------------------------------------------

  Future<void> increaseQuantity(
    CartItemModel item,
  ) async {
    await CartRepository.updateQuantity(
      item.productId,
      item.quantity + 1,
    );
  }

  //----------------------------------------------------------
  // Decrease Quantity
  //----------------------------------------------------------

  Future<void> decreaseQuantity(
    CartItemModel item,
  ) async {
    await CartRepository.updateQuantity(
      item.productId,
      item.quantity - 1,
    );
  }

  //----------------------------------------------------------
  // Remove Item
  //----------------------------------------------------------

  Future<void> removeItem(
    String productId,
  ) async {
    await CartRepository.removeItem(
      productId,
    );
  }

  //----------------------------------------------------------
  // Clear Cart
  //----------------------------------------------------------

  Future<void> clearCart() async {
    await CartRepository.clearCart();
  }
}