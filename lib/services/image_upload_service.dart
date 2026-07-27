import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadService {
  ImageUploadService._();

  static final FirebaseStorage _storage =
      FirebaseStorage.instance;

  /// Uploads profile image to Firebase Storage
  ///
  /// Path:
  /// users/{uid}/profile/profile.jpg
  static Future<String> uploadProfileImage({
    required String uid,
    required Uint8List imageBytes,
  }) async {
    try {
      final ref = _storage
          .ref()
          .child('users')
          .child(uid)
          .child('profile')
          .child('profile.jpg');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      final uploadTask = await ref.putData(
        imageBytes,
        metadata,
      );

      final downloadUrl =
          await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? 'Failed to upload image.',
      );
    } catch (e) {
      throw Exception(
        'Image upload failed.',
      );
    }
  }

  /// Delete existing profile image
  static Future<void> deleteProfileImage({
    required String uid,
  }) async {
    try {
      final ref = _storage
          .ref()
          .child('users')
          .child(uid)
          .child('profile')
          .child('profile.jpg');

      await ref.delete();
    } catch (_) {
      // Ignore if image doesn't exist
    }
  }
}