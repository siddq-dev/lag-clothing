import 'package:flutter/material.dart';

import '../models/address_model.dart';
import '../models/checkout_model.dart';
import '../repositories/checkout_repository.dart';

class CheckoutProvider extends ChangeNotifier {
  CheckoutProvider({CheckoutRepository? repository})
    : _repository = repository ?? CheckoutRepository();

  final CheckoutRepository _repository;

  CheckoutModel? _checkout;

  bool _isLoading = false;
  String? _error;

  CheckoutModel? get checkout => _checkout;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // ============================================================
  // INITIALIZE
  // ============================================================

  Future<void> initialize() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final cartItems = await _repository.getCartItems();

      if (cartItems.isEmpty) {
        _checkout = const CheckoutModel(
          shippingAddress: null,
          billingAddress: null,
          cartItems: [],
          coupon: null,
          paymentMethod: null,
          subtotal: 0,
          tax: 0,
          discount: 0,
          grandTotal: 0,
        );

        return;
      }

      final subtotal = cartItems.fold<double>(
        0,
        (sum, item) => sum + item.total,
      );

      const taxRate = 0.05;

      final tax = subtotal * taxRate;

      const discount = 0.0;

      final grandTotal = subtotal + tax - discount;

      _checkout = CheckoutModel(
        shippingAddress: null,
        billingAddress: null,
        cartItems: List.unmodifiable(cartItems),
        coupon: null,
        paymentMethod: null,
        subtotal: subtotal,
        tax: tax,
        discount: discount,
        grandTotal: grandTotal,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============================================================
  // SHIPPING ADDRESS
  // ============================================================

  void setShippingAddress(AddressModel address) {
    if (_checkout == null) {
      return;
    }

    final normalizedAddress = address.copyWith(
      purpose: AddressPurpose.shipping,
      isDefault: false,
    );

    _checkout = _checkout!.copyWith(shippingAddress: normalizedAddress);

    _error = null;

    notifyListeners();
  }

  // ============================================================
  // BILLING ADDRESS
  // ============================================================

  void setBillingAddress(AddressModel address) {
    if (_checkout == null) {
      return;
    }

    final normalizedAddress = address.copyWith(
      purpose: AddressPurpose.billing,
      isDefault: false,
    );

    _checkout = _checkout!.copyWith(billingAddress: normalizedAddress);

    _error = null;

    notifyListeners();
  }

  // ============================================================
  // CLEAR SHIPPING
  // ============================================================

  void clearShippingAddress() {
    if (_checkout == null) {
      return;
    }

    _checkout = _checkout!.copyWith(clearShippingAddress: true);

    notifyListeners();
  }

  // ============================================================
  // CLEAR BILLING
  // ============================================================

  void clearBillingAddress() {
    if (_checkout == null) {
      return;
    }

    _checkout = _checkout!.copyWith(clearBillingAddress: true);

    notifyListeners();
  }

  // ============================================================
  // PAYMENT
  // ============================================================

  void selectPayment(String payment) {
    if (_checkout == null) {
      return;
    }

    final value = payment.trim();

    if (value.isEmpty) {
      return;
    }

    _checkout = _checkout!.copyWith(paymentMethod: value);

    _error = null;

    notifyListeners();
  }

  // ============================================================
  // DISCOUNT
  // ============================================================

  void applyDiscount(double discount) {
    if (_checkout == null) {
      return;
    }

    final safeDiscount = discount.clamp(
      0.0,
      _checkout!.subtotal + _checkout!.tax,
    );

    final grandTotal = _checkout!.subtotal + _checkout!.tax - safeDiscount;

    _checkout = _checkout!.copyWith(
      discount: safeDiscount,
      grandTotal: grandTotal < 0 ? 0.0 : grandTotal,
    );

    notifyListeners();
  }

  // ============================================================
  // VALIDATE CHECKOUT
  // ============================================================

  bool validateCheckout() {
    final currentCheckout = _checkout;

    if (currentCheckout == null) {
      _error = 'Checkout is unavailable.';
      notifyListeners();
      return false;
    }

    if (!currentCheckout.hasProducts) {
      _error = 'Your cart is empty.';
      notifyListeners();
      return false;
    }

    if (!currentCheckout.hasShippingAddress) {
      _error = 'Please complete the shipping address.';
      notifyListeners();
      return false;
    }

    if (!currentCheckout.hasBillingAddress) {
      _error = 'Please complete the billing address.';
      notifyListeners();
      return false;
    }

    if (!currentCheckout.hasPaymentMethod) {
      _error = 'Please select a payment method.';
      notifyListeners();
      return false;
    }

    return true;
  }

  // ============================================================
  // PLACE ORDER
  // ============================================================

  Future<bool> placeOrder() async {
    if (!validateCheckout()) {
      return false;
    }

    final currentCheckout = _checkout;

    if (currentCheckout == null) {
      return false;
    }

    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final orderNumber = _repository.generateOrderNumber();

      final trackingId = _repository.generateTrackingId();

      final orderData = {
        // --------------------------------------------------------
        // USER
        // --------------------------------------------------------

        // userId is added by CheckoutRepository.
        // Do not duplicate it here.

        // --------------------------------------------------------
        // ORDER IDENTIFIERS
        // --------------------------------------------------------
        'orderNumber': orderNumber,
        'trackingId': trackingId,

        // --------------------------------------------------------
        // ADDRESSES
        // --------------------------------------------------------
        'shippingAddress': currentCheckout.shippingAddress!.toMap(),

        'billingAddress': currentCheckout.billingAddress!.toMap(),

        // --------------------------------------------------------
        // ITEMS
        // --------------------------------------------------------
        'items': currentCheckout.cartItems.map((item) => item.toMap()).toList(),

        // --------------------------------------------------------
        // PAYMENT
        // --------------------------------------------------------
        'paymentMethod': currentCheckout.paymentMethod,

        // --------------------------------------------------------
        // TOTALS
        // --------------------------------------------------------
        'subtotal': currentCheckout.subtotal,

        'tax': currentCheckout.tax,

        'discount': currentCheckout.discount,

        'grandTotal': currentCheckout.grandTotal,

        // --------------------------------------------------------
        // STATUS
        // --------------------------------------------------------
        'orderStatus': 'pending',

        'paymentStatus': 'pending',
      };

      // ----------------------------------------------------------
      // CREATE ORDER + VALIDATE PRICE/STOCK + UPDATE INVENTORY
      // ----------------------------------------------------------

      await _repository.createOrder(
        orderData: orderData,
        items: currentCheckout.cartItems,
      );

      // ----------------------------------------------------------
      // CLEAR CART ONLY AFTER SUCCESSFUL ORDER TRANSACTION
      // ----------------------------------------------------------

      await _repository.clearCart();

      // ----------------------------------------------------------
      // CLEAR LOCAL CHECKOUT
      // ----------------------------------------------------------

      _checkout = null;

      return true;
    } catch (e) {
      _error = e.toString();

      return false;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> refresh() async {
    await initialize();
  }
}
