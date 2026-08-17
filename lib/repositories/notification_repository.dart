import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notification_settings_model.dart';

class NotificationRepository {
  NotificationRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get _uid => _auth.currentUser!.uid;

  static DocumentReference<Map<String, dynamic>> get _document => _firestore
      .collection('users')
      .doc(_uid)
      .collection('notification_settings')
      .doc('settings');

  // ==========================================
  // Get Notification Settings
  // ==========================================

  static Future<NotificationSettingsModel> getSettings() async {
    final snapshot = await _document.get();

    if (!snapshot.exists) {
      final settings = NotificationSettingsModel(
        orderUpdates: true,
        promotions: true,
        newArrivals: true,
        backInStock: true,
        pushNotifications: true,
        emailNotifications: true,
        smsNotifications: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await _document.set(settings.toMap());

      return settings;
    }

    return NotificationSettingsModel.fromMap(snapshot.data()!);
  }

  // ==========================================
  // Stream Notification Settings
  // ==========================================

  static Stream<NotificationSettingsModel> streamSettings() {
    return _document.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return const NotificationSettingsModel(
          orderUpdates: true,
          promotions: true,
          newArrivals: true,
          backInStock: true,
          pushNotifications: true,
          emailNotifications: true,
          smsNotifications: false,
        );
      }

      return NotificationSettingsModel.fromMap(snapshot.data()!);
    });
  }

  // ==========================================
  // Save Notification Settings
  // ==========================================

  static Future<void> updateSettings(NotificationSettingsModel settings) async {
    await _document.set({
      ...settings.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
