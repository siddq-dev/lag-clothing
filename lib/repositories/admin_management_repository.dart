import '../../../../models/user_model.dart';
import '../services/admin_firestore_service.dart';

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
  }) {
    return AdminFirestoreService.createAdmin(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }

  static Future<void> updateAdmin({
  required String uid,
  required String name,
  required String phone,
  required bool status,
}) {
  return AdminFirestoreService.updateAdmin(
    uid: uid,
    name: name,
    phone: phone,
    status: status,
  );
}

static Future<void> sendPasswordReset(
  String email,
) {
  return AdminFirestoreService
      .sendPasswordReset(email);
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

  static Future<void> deleteAdmin(
    String uid,
  ) {
    return AdminFirestoreService.deleteAdmin(uid);
  }


  // ==========================
  // Update Status
  // ==========================

  static Future<void> updateStatus({
    required String uid,
    required bool status,
  }) {
    return AdminFirestoreService.updateStatus(
      uid: uid,
      status: status,
    );
  }
}