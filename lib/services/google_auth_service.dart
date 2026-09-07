import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final GoogleAuthProvider provider = GoogleAuthProvider();

        provider.setCustomParameters({'prompt': 'select_account'});

        userCredential = await _auth.signInWithPopup(provider);
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

    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        'uid': user.uid,
        'fullName': user.displayName ?? '',
        'email': user.email ?? '',
        'phone': user.phoneNumber ?? '',
        'photoUrl': user.photoURL ?? '',
        'role': 'customer',
        // Required by firestore.rules' users update rule, which
        // compares these fields before/after every update. Omitting
        // them causes ANY future .update() on this doc (last-login
        // timestamps, profile edits, etc.) to fail with
        // permission-denied, since the rule can't safely compare a
        // field that doesn't exist on the document at all.
        // firestore.rules' create rule for /users/{userId}
        // requires every one of these 9 permission keys to be
        // explicitly present and false at creation time (plus
        // status: true). A missing key, or an empty {} map,
        // fails that rule the same way an entirely-missing
        // "permissions" field breaks the update rule.
        'status': true,
        'permissions': {
          'dashboard': false,
          'products': false,
          'orders': false,
          'customers': false,
          'inventory': false,
          'coupons': false,
          'analytics': false,
          'admins': false,
          'settings': false,
        },
        'addresses': [],
        'wishlist': [],
        'cart': [],
        'orders': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
