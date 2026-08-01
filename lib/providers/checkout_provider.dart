import 'package:flutter/material.dart';

import '../models/address_model.dart';
import '../models/cart_item_model.dart';
import '../models/checkout_model.dart';
import '../repositories/checkout_repository.dart';

class CheckoutProvider extends ChangeNotifier {
  CheckoutProvider({
    CheckoutRepository? repository,
  }) : _repository = repository ?? CheckoutRepository();

  final CheckoutRepository _repository;

  CheckoutModel? _checkout;

  CheckoutModel? get checkout => _checkout;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  //----------------------------------------------------------
  // Initialize Checkout
  //----------------------------------------------------------

  Future<void> initialize() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final address =
          await _repository.getDefaultAddress();

      final cartItems =
          await _repository.getCartItems();

      final subtotal = cartItems.fold<double>(
        0,
        (sum, item) => sum + item.total,
      );

      final shipping = cartItems.isEmpty ? 0.0 : 100.0;

      final tax = subtotal * 0.05;

      _checkout = CheckoutModel(
        selectedAddress: address,
        cartItems: cartItems,
        coupon: null,
        shippingMethod: "standard",
        paymentMethod: "card",
        subtotal: subtotal,
        shippingCharge: shipping,
        tax: tax,
        discount: 0,
        grandTotal:
            subtotal + shipping + tax,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  //----------------------------------------------------------
  // Address
  //----------------------------------------------------------

  void selectAddress(
    AddressModel address,
  ) {
    _checkout = _checkout?.copyWith(
      selectedAddress: address,
    );

    notifyListeners();
  }

  //----------------------------------------------------------
  // Shipping
  //----------------------------------------------------------

  void selectShipping(
    String method,
    double charge,
  ) {
    if (_checkout == null) return;

    _checkout = _checkout!.copyWith(
      shippingMethod: method,
      shippingCharge: charge,
      grandTotal:
          _checkout!.subtotal +
          charge +
          _checkout!.tax -
          _checkout!.discount,
    );

    notifyListeners();
  }

  //----------------------------------------------------------
  // Payment
  //----------------------------------------------------------

  void selectPayment(
    String payment,
  ) {
    if (_checkout == null) return;

    _checkout = _checkout!.copyWith(
      paymentMethod: payment,
    );

    notifyListeners();
  }

  //----------------------------------------------------------
  // Coupon
  //----------------------------------------------------------

  void applyDiscount(
    double discount,
  ) {
    if (_checkout == null) return;

 _checkout = _checkout!.copyWith(
  discount: discount,
  grandTotal:
      _checkout!.subtotal +
      _checkout!.shippingCharge +
      _checkout!.tax -
      discount,
);

    notifyListeners();
  }

  //----------------------------------------------------------
  // Place Order
  //----------------------------------------------------------

  Future<bool> placeOrder() async {
    if (_checkout == null) {
      return false;
    }

    try {
      final validStock =
          await _repository.validateInventory(
        _checkout!.cartItems,
      );

      if (!validStock) {
        _error =
            "Some items are out of stock.";

        notifyListeners();

        return false;
      }

      final validPrices =
          await _repository.validatePrices(
        _checkout!.cartItems,
      );

      if (!validPrices) {
        _error =
            "Prices changed. Please refresh cart.";

        notifyListeners();

        return false;
      }

      final orderNumber =
          _repository.generateOrderNumber();

      final trackingId =
          _repository.generateTrackingId();

      await _repository.createOrder(
        orderData: {
          "orderNumber": orderNumber,
          "trackingId": trackingId,
          "address":
              _checkout!.selectedAddress?.toMap(),
          "items": _checkout!.cartItems
              .map((e) => e.toMap())
              .toList(),
          "paymentMethod":
              _checkout!.paymentMethod,
          "shippingMethod":
              _checkout!.shippingMethod,
          "subtotal":
              _checkout!.subtotal,
          "shipping":
              _checkout!.shippingCharge,
          "tax":
              _checkout!.tax,
          "discount":
              _checkout!.discount,
          "grandTotal":
              _checkout!.grandTotal,
          "orderStatus": "pending",
          "paymentStatus": "pending",
          "createdAt":
              DateTime.now(),
        },
      );

      await _repository.updateInventory(
        _checkout!.cartItems,
      );

      await _repository.clearCart();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }
}