import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class ProductStorageService {
  ProductStorageService._();

  static final FirebaseStorage _storage =
      FirebaseStorage.instance;

  /// Upload a single image
  static Future<String> uploadImage({
    required String productId,
    required String fileName,
    required Uint8List imageBytes,
  }) async {
    final ref = _storage
        .ref()
        .child("products")
        .child(productId)
        .child(fileName);

    final task = await ref.putData(imageBytes);

    return await task.ref.getDownloadURL();
  }

  /// Delete a single image
  static Future<void> deleteImage(
    String imageUrl,
  ) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (_) {}
  }

  /// Delete all images of a product
  static Future<void> deleteProductFolder(
    String productId,
  ) async {
    final folder = _storage
        .ref()
        .child("products")
        .child(productId);

    final result = await folder.listAll();

    for (final item in result.items) {
      await item.delete();
    }
  }
}