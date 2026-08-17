import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';
import '../repositories/admin_management_repository.dart';
import '../../../../models/admin_permission_model.dart';

class AdminManagementProvider extends ChangeNotifier {
  bool _loading = false;

  String? _error;

  List<UserModel> _admins = [];

  bool get loading => _loading;

  String? get error => _error;

  List<UserModel> get admins => _admins;

  Future<void> createAdmin({
    required String name,
    required String email,
    required String phone,
    required String password,
    required AdminPermissionModel permissions,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      await AdminManagementRepository.createAdmin(
        name: name,
        email: email,
        phone: phone,
        password: password,
        permissions: permissions,
      );

      await loadAdmins();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadAdmins() async {
    _loading = true;
    notifyListeners();

    try {
      _admins = await AdminManagementRepository.getAdmins();

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> updateAdmin({
    required String uid,
    required String name,
    required String phone,
    required bool status,
    required AdminPermissionModel permissions,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      await AdminManagementRepository.updateAdmin(
        uid: uid,
        name: name,
        phone: phone,
        status: status,
        permissions: permissions,
      );

      await loadAdmins();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAdmin(String uid) async {
    await AdminManagementRepository.deleteAdmin(uid);

    await loadAdmins();
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await AdminManagementRepository.sendPasswordReset(email);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateStatus({required String uid, required bool status}) async {
    await AdminManagementRepository.updateStatus(uid: uid, status: status);

    await loadAdmins();
  }
}
