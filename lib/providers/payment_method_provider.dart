import 'package:flutter/material.dart';

import '../models/payment_method_model.dart';
import '../repositories/payment_method_repository.dart';

class PaymentMethodProvider extends ChangeNotifier {
  List<PaymentMethodModel> _paymentMethods = [];

  bool _isLoading = false;
  String? _error;

  List<PaymentMethodModel> get paymentMethods =>
      _paymentMethods;

  bool get isLoading => _isLoading;

  String? get error => _error;

  PaymentMethodModel? get defaultPaymentMethod {
    try {
      return _paymentMethods.firstWhere(
        (card) => card.isDefault,
      );
    } catch (_) {
      return null;
    }
  }

  // ==========================================
  // Load Cards
  // ==========================================

  Future<void> loadPaymentMethods() async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _paymentMethods =
          await PaymentMethodRepository
              .getPaymentMethods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // Listen Cards
  // ==========================================

  void listenPaymentMethods() {
    PaymentMethodRepository
        .streamPaymentMethods()
        .listen(
      (cards) {
        _paymentMethods = cards;
        notifyListeners();
      },
    );
  }

  // ==========================================
  // Add Card
  // ==========================================

  Future<void> addPaymentMethod(
    PaymentMethodModel card,
  ) async {
    try {
      _isLoading = true;

      notifyListeners();

      await PaymentMethodRepository
          .addPaymentMethod(card);

      await loadPaymentMethods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================
  // Update Card
  // ==========================================

  Future<void> updatePaymentMethod(
    PaymentMethodModel card,
  ) async {
    try {
      _isLoading = true;

      notifyListeners();

      await PaymentMethodRepository
          .updatePaymentMethod(card);

      await loadPaymentMethods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================
  // Delete Card
  // ==========================================

  Future<void> deletePaymentMethod(
    String id,
  ) async {
    try {
      _isLoading = true;

      notifyListeners();

      await PaymentMethodRepository
          .deletePaymentMethod(id);

      await loadPaymentMethods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================
  // Set Default Card
  // ==========================================

  Future<void> setDefaultPaymentMethod(
    String id,
  ) async {
    try {
      _isLoading = true;

      notifyListeners();

      await PaymentMethodRepository
          .setDefaultPaymentMethod(id);

      await loadPaymentMethods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================
  // Refresh
  // ==========================================

  Future<void> refresh() async {
    await loadPaymentMethods();
  }
}