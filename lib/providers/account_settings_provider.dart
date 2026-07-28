import 'package:flutter/material.dart';

import '../models/account_settings_model.dart';
import '../repositories/account_settings_repository.dart';

class AccountSettingsProvider extends ChangeNotifier {
  AccountSettingsModel? _settings;

  AccountSettingsModel? get settings => _settings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;


  // ==========================================
  // Load Account Settings
  // ==========================================

  Future<void> loadSettings() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _settings =
          await AccountSettingsRepository.getSettings();

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // ==========================================
  // Listen Account Settings Changes
  // ==========================================

  Stream<void> listenSettings() {
    return AccountSettingsRepository
        .streamSettings()
        .map((data) {

      _settings = data;

      notifyListeners();

    });
  }


  // ==========================================
  // Update Private Account
  // ==========================================

  Future<void> updatePrivateAccount(
    bool value,
  ) async {

    if (_settings == null) return;


    _settings = _settings!.copyWith(
      privateAccount: value,
    );

    notifyListeners();


    await _updateBackend();
  }



  // ==========================================
  // Update Personalized Ads
  // ==========================================

  Future<void> updatePersonalizedAds(
    bool value,
  ) async {

    if (_settings == null) return;


    _settings = _settings!.copyWith(
      personalizedAds: value,
    );

    notifyListeners();


    await _updateBackend();
  }



  // ==========================================
  // Update Biometric Login
  // ==========================================

  Future<void> updateBiometricLogin(
    bool value,
  ) async {

    if (_settings == null) return;


    _settings = _settings!.copyWith(
      biometricLogin: value,
    );

    notifyListeners();


    await _updateBackend();
  }



  // ==========================================
  // Save Changes To Firebase
  // ==========================================

  Future<void> _updateBackend() async {

    try {

      await AccountSettingsRepository
          .updateSettings(
            _settings!,
          );

    } catch (e) {

      _error = e.toString();

      notifyListeners();

    }
  }



  // ==========================================
  // Reset Provider
  // ==========================================

  void clear() {

    _settings = null;

    _error = null;

    notifyListeners();

  }

}