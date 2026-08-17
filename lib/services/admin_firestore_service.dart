import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../firebase_options.dart';
import '../../../../models/user_model.dart';
import '../../../../models/admin_permission_model.dart';

class AdminFirestoreService {
  AdminFirestoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection("users");

  // ==============================
  // Load All Admins
  // ==============================

  static Future<List<UserModel>> getAdmins() async {
    final snapshot = await _users.where("role", isEqualTo: "admin").get();

    return snapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  // ==============================
  // Create Admin
  // ==============================

  static Future<void> createAdmin({
    required String name,
    required String email,
    required String phone,
    required String password,
    required AdminPermissionModel permissions,
  }) async {
    FirebaseApp? secondaryApp;

    try {
      secondaryApp = await Firebase.initializeApp(
        name: "AdminCreator",
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (_) {
      secondaryApp = Firebase.app("AdminCreator");
    }

    final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

    final credential = await secondaryAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final user = UserModel(
      uid: uid,
      name: name,
      email: email,
      phone: phone,
      role: UserRole.admin,
      status: true,
      permissions: permissions,
    );

    await _users.doc(uid).set(user.toMap());

    await secondaryAuth.signOut();
  }

  // ==============================
  // Delete Admin
  // ==============================

  static Future<void> deleteAdmin(String uid) async {
    await _users.doc(uid).delete();
  }

  // ==============================
  // Reset Password
  // ==============================

  static Future<void> sendPasswordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // ==============================
  // Update Status
  // ==============================

  static Future<void> updateStatus({
    required String uid,
    required bool status,
  }) async {
    await _users.doc(uid).update({"status": status});
  }

  // ==============================
  // Update Admin
  // ==============================

  static Future<void> updateAdmin({
    required String uid,
    required String name,
    required String phone,
    required bool status,
    required AdminPermissionModel permissions,
  }) async {
    await _users.doc(uid).update({
      "name": name,
      "phone": phone,
      "status": status,
      "permissions": permissions.toMap(),
      "updatedAt": Timestamp.now(),
    });
  }
}
