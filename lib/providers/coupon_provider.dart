import 'package:flutter/material.dart';

import '../models/coupon_model.dart';
import '../repositories/coupon_repository.dart';

class CouponProvider extends ChangeNotifier {
  CouponProvider({CouponRepository? repository})
    : _repository = repository ?? CouponRepository();

  final CouponRepository _repository;

  //----------------------------------------------------------
  // State
  //----------------------------------------------------------

  CouponModel? _coupon;

  CouponModel? get coupon => _coupon;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  double _discount = 0;

  double get discount => _discount;

  String _couponCode = "";

  String get couponCode => _couponCode;

  //----------------------------------------------------------
  // Apply Coupon
  //----------------------------------------------------------

  Future<bool> applyCoupon({
    required String code,
    required double subtotal,

    required List<String> productIds,
  }) async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final result = await _repository.validateCoupon(
        code: code,
        subtotal: subtotal,

        productIds: productIds,
      );

      _coupon = result;

      _couponCode = result.code;

      _discount = _repository.calculateDiscount(
        coupon: result,
        subtotal: subtotal,
      );

      _isLoading = false;

      notifyListeners();

      return true;
    } catch (e) {
      _coupon = null;
      _discount = 0;

      _error = e.toString().replaceFirst("Exception: ", "");

      _isLoading = false;

      notifyListeners();

      return false;
    }
  }

  //----------------------------------------------------------
  // Remove Coupon
  //----------------------------------------------------------

  void removeCoupon() {
    _coupon = null;

    _discount = 0;

    _couponCode = "";

    _error = null;

    notifyListeners();
  }

  //----------------------------------------------------------
  // Clear
  //----------------------------------------------------------

  void clear() {
    removeCoupon();
  }
}
