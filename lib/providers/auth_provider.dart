import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;

  UserModel? _currentUser;

  String? _error;

  bool get loading => _loading;

  UserModel? get currentUser => _currentUser;

  String? get error => _error;

  // ===============================
  // LOGIN
  // ===============================

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final credential =
          await AuthRepository.login(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      _currentUser =
          await AuthRepository.getUser(uid);

      await AuthRepository.updateLastLogin(uid);

      _loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      _loading = false;
      notifyListeners();

      return false;
    }
  }

  // ===============================
  // REGISTER CUSTOMER
  // ===============================

  Future<bool> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final credential =
          await AuthRepository.register(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        role: UserRole.customer,
        status: true,
      );

      await AuthRepository.saveCustomer(
        user: user,
      );

      _currentUser = user;

      _loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      _loading = false;
      notifyListeners();

      return false;
    }
  }

  // ===============================
  // LOGOUT
  // ===============================

  Future<void> logout() async {
    await AuthRepository.logout();

    _currentUser = null;

    notifyListeners();
  }
}