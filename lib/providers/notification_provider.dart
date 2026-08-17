import 'package:flutter/material.dart';

import '../models/notification_settings_model.dart';
import '../repositories/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationSettingsModel? _settings;

  bool _isLoading = false;
  String? _error;

  NotificationSettingsModel? get settings => _settings;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // ==========================================
  // Load Settings
  // ==========================================

  Future<void> loadSettings() async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _settings = await NotificationRepository.getSettings();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // Listen
  // ==========================================

  void listenSettings() {
    NotificationRepository.streamSettings().listen((settings) {
      _settings = settings;
      notifyListeners();
    });
  }

  // ==========================================
  // Save Settings
  // ==========================================

  Future<void> updateSettings(NotificationSettingsModel settings) async {
    try {
      _isLoading = true;

      notifyListeners();

      await NotificationRepository.updateSettings(settings);

      _settings = settings;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================
  // Individual Toggles
  // ==========================================

  Future<void> toggleOrderUpdates(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(orderUpdates: value));
  }

  Future<void> togglePromotions(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(promotions: value));
  }

  Future<void> toggleNewArrivals(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(newArrivals: value));
  }

  Future<void> toggleBackInStock(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(backInStock: value));
  }

  Future<void> togglePushNotifications(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(pushNotifications: value));
  }

  Future<void> toggleEmailNotifications(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(emailNotifications: value));
  }

  Future<void> toggleSmsNotifications(bool value) async {
    if (_settings == null) return;

    await updateSettings(_settings!.copyWith(smsNotifications: value));
  }

  // ==========================================
  // Refresh
  // ==========================================

  Future<void> refresh() async {
    await loadSettings();
  }
}
