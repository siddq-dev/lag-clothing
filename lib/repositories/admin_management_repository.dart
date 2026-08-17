import '../../../../models/user_model.dart';
import '../services/admin_firestore_service.dart';
import '../../../../models/admin_permission_model.dart';

class AdminManagementRepository {
  AdminManagementRepository._();

  // ==========================
  // Create Admin
  // ==========================

  static Future<void> createAdmin({
    required String name,
    required String email,
    required String phone,
    required String password,
    required AdminPermissionModel permissions,
  }) {
    return AdminFirestoreService.createAdmin(
      name: name,
      email: email,
      phone: phone,
      password: password,
      permissions: permissions,
    );
  }

  static Future<void> updateAdmin({
    required String uid,
    required String name,
    required String phone,
    required bool status,
    required AdminPermissionModel permissions,
  }) {
    return AdminFirestoreService.updateAdmin(
      uid: uid,
      name: name,
      phone: phone,
      status: status,
      permissions: permissions,
    );
  }

  static Future<void> sendPasswordReset(String email) {
    return AdminFirestoreService.sendPasswordReset(email);
  }

  // ==========================
  // Get All Admins
  // ==========================

  static Future<List<UserModel>> getAdmins() {
    return AdminFirestoreService.getAdmins();
  }

  // ==========================
  // Delete Admin
  // ==========================

  static Future<void> deleteAdmin(String uid) {
    return AdminFirestoreService.deleteAdmin(uid);
  }

  // ==========================
  // Update Status
  // ==========================

  static Future<void> updateStatus({
    required String uid,
    required bool status,
  }) {
    return AdminFirestoreService.updateStatus(uid: uid, status: status);
  }
}
