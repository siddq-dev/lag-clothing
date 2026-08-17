import 'package:flutter/material.dart';

import '../models/customer_model.dart';
import '../repositories/customer_repository.dart';

class CustomerProvider extends ChangeNotifier {
  CustomerModel? _customer;

  bool _isLoading = false;
  String? _error;

  CustomerModel? get customer => _customer;

  bool get isLoading => _isLoading;

  String? get error => _error;

  bool get hasCustomer => _customer != null;

  /// -------------------------------
  /// Load Customer
  /// -------------------------------
  Future<void> loadCustomer() async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _customer = await CustomerRepository.getCurrentCustomer();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// -------------------------------
  /// Refresh Customer
  /// -------------------------------
  Future<void> refresh() async {
    await loadCustomer();
  }

  /// -------------------------------
  /// Update Name & Phone
  /// -------------------------------
  Future<bool> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      await CustomerRepository.updateProfile(fullName: fullName, phone: phone);

      await loadCustomer();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// -------------------------------
  /// Update Profile Photo
  /// -------------------------------
  Future<bool> updatePhotoUrl(String photoUrl) async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      await CustomerRepository.updatePhotoUrl(photoUrl);

      await loadCustomer();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// -------------------------------
  /// Update Address List
  /// -------------------------------
  Future<bool> updateAddresses(List<dynamic> addresses) async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      await CustomerRepository.updateAddresses(addresses);

      await loadCustomer();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// -------------------------------
  /// Clear Provider
  /// -------------------------------
  void clear() {
    _customer = null;
    _error = null;
    _isLoading = false;

    notifyListeners();
  }
}
