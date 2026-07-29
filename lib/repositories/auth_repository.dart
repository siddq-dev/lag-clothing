import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user_model.dart';

class AuthRepository {
  AuthRepository._();

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static User? get currentUser =>
      _auth.currentUser;

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static Future<UserModel?> getUser(
    String uid,
  ) async {
    final doc =
        await _firestore
            .collection("users")
            .doc(uid)
            .get();

    if (!doc.exists) {
      return null;
    }

    return UserModel.fromMap(
      doc.data()!,
    );
  }

  static Future<void> saveCustomer({
    required UserModel user,
  }) async {
    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(user.toMap());
  }

  static Future<void> updateLastLogin(
    String uid,
  ) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({
      "lastLogin": Timestamp.now(),
    });
  }
}