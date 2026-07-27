import 'package:flutter/material.dart';

import '../models/address_model.dart';
import '../repositories/address_repository.dart';

class AddressProvider extends ChangeNotifier {
  List<AddressModel> _addresses = [];

  bool _isLoading = false;
  String? _error;

  List<AddressModel> get addresses => _addresses;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // ==========================
  // Shipping Addresses
  // ==========================

  List<AddressModel> get shippingAddresses =>
      _addresses
          .where(
            (e) => e.purpose == AddressPurpose.shipping,
          )
          .toList();

  // ==========================
  // Billing Addresses
  // ==========================

  List<AddressModel> get billingAddresses =>
      _addresses
          .where(
            (e) => e.purpose == AddressPurpose.billing,
          )
          .toList();

  // ==========================
  // Default Shipping
  // ==========================

  AddressModel? get defaultShippingAddress {
    try {
      return shippingAddresses.firstWhere(
        (e) => e.isDefault,
      );
    } catch (_) {
      return null;
    }
  }

  // ==========================
  // Default Billing
  // ==========================

  AddressModel? get defaultBillingAddress {
    try {
      return billingAddresses.firstWhere(
        (e) => e.isDefault,
      );
    } catch (_) {
      return null;
    }
  }

  // ==========================
  // Load Addresses
  // ==========================

  Future<void> loadAddresses() async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _addresses =
          await AddressRepository.getAddresses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================
  // Listen Addresses
  // ==========================

  void listenAddresses() {
    AddressRepository.streamAddresses().listen(
      (list) {
        _addresses = list;
        notifyListeners();
      },
    );
  }

  // ==========================
  // Add Address
  // ==========================

  Future<void> addAddress(
    AddressModel address,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      await AddressRepository.addAddress(address);

      await loadAddresses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================
  // Update Address
  // ==========================

  Future<void> updateAddress(
    AddressModel address,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      await AddressRepository.updateAddress(address);

      await loadAddresses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================
  // Delete Address
  // ==========================

  Future<void> deleteAddress(
    String id,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      await AddressRepository.deleteAddress(id);

      await loadAddresses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================
  // Set Default
  // ==========================

  Future<void> setDefaultAddress(
    String id,
    AddressPurpose purpose,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      await AddressRepository.setDefaultAddress(
        id,
        purpose,
      );

      await loadAddresses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================
  // Refresh
  // ==========================

  Future<void> refresh() async {
    await loadAddresses();
  }
}