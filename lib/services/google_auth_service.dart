import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final GoogleAuthProvider provider = GoogleAuthProvider();

        provider.setCustomParameters({
          'prompt': 'select_account',
        });

        userCredential =
            await _auth.signInWithPopup(provider);
      } else {
        throw UnimplementedError(
          'Google Sign-In for Android/iOS will be added later.',
        );
      }

      await _createUserDocument(userCredential.user);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _createUserDocument(User? user) async {
    if (user == null) return;

    final doc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        'uid': user.uid,
        'fullName': user.displayName ?? '',
        'email': user.email ?? '',
        'phone': user.phoneNumber ?? '',
        'photoUrl': user.photoURL ?? '',
        'role': 'customer',
        'addresses': [],
        'wishlist': [],
        'cart': [],
        'orders': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}