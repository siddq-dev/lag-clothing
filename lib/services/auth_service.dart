import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ==========================
  // Register Customer
  // ==========================
  static Future<UserCredential> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final UserCredential credential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'role': 'customer',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }

  // ==========================
  // Login
  // ==========================
  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ==========================
  // Logout
  // ==========================
  static Future<void> logout() async {
    await _auth.signOut();
  }

 // ==========================
// Forgot Password
// ==========================
static Future<void> forgotPassword(String email) async {
  await _auth.sendPasswordResetEmail(
    email: email.trim(),
  );
}
  // ==========================
  // Current User
  // ==========================
  static User? get currentUser => _auth.currentUser;
}