import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  FirebaseStorageService._();

  static final FirebaseStorage _storage =
      FirebaseStorage.instance;

  //==========================================================
  // Upload Product Image
  //==========================================================

  static Future<String> uploadProductImage(
    XFile image,
  ) async {
    try {
      final file = File(image.path);

      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${image.name}";

      final ref = _storage
          .ref()
          .child("products")
          .child(fileName);

      final uploadTask = await ref.putFile(file);

      final downloadUrl =
          await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception(
        "Failed to upload product image: $e",
      );
    }
  }

  //==========================================================
  // Upload Multiple Images
  //==========================================================

  static Future<List<String>> uploadProductImages(
    List<XFile> images,
  ) async {
    final List<String> urls = [];

    for (final image in images) {
      final url =
          await uploadProductImage(image);

      urls.add(url);
    }

    return urls;
  }

  //==========================================================
  // Delete Image
  //==========================================================

  static Future<void> deleteImage(
    String imageUrl,
  ) async {
    try {
      final ref =
          _storage.refFromURL(imageUrl);

      await ref.delete();
    } catch (e) {
      throw Exception(
        "Failed to delete image: $e",
      );
    }
  }

  //==========================================================
  // Replace Image
  //==========================================================

  static Future<String> replaceImage({
    required String oldImageUrl,
    required XFile newImage,
  }) async {
    try {
      await deleteImage(oldImageUrl);

      return await uploadProductImage(
        newImage,
      );
    } catch (e) {
      throw Exception(
        "Failed to replace image: $e",
      );
    }
  }
}