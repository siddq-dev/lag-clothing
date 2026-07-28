import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/account_settings_model.dart';

class AccountSettingsRepository {
  AccountSettingsRepository._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static String get _uid => _auth.currentUser!.uid;

  static DocumentReference<Map<String, dynamic>>
      get _document =>
          _firestore
              .collection('users')
              .doc(_uid)
              .collection('account_settings')
              .doc('settings');

  // ==========================================
  // Load Settings
  // ==========================================

  static Future<AccountSettingsModel> getSettings() async {
    final snapshot = await _document.get();

    if (!snapshot.exists) {
      final settings = AccountSettingsModel(
        privateAccount: false,
        personalizedAds: true,
        biometricLogin: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await _document.set(settings.toMap());

      return settings;
    }

    return AccountSettingsModel.fromMap(
      snapshot.data()!,
    );
  }

  // ==========================================
  // Stream Settings
  // ==========================================

  static Stream<AccountSettingsModel> streamSettings() {
    return _document.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return AccountSettingsModel(
          privateAccount: false,
          personalizedAds: true,
          biometricLogin: false,
        );
      }

      return AccountSettingsModel.fromMap(
        snapshot.data()!,
      );
    });
  }

  // ==========================================
  // Update Settings
  // ==========================================

  static Future<void> updateSettings(
    AccountSettingsModel settings,
  ) async {
    await _document.set(
      settings.copyWith(
        updatedAt: Timestamp.now(),
      ).toMap(),
      SetOptions(merge: true),
    );
  }
}