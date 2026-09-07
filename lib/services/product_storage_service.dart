import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProductStorageService {
  ProductStorageService._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static const int maxImageSize = 2 * 1024 * 1024;

  static const List<String> allowedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];

  // ----------------------------------------------------------
  // Upload image selected from ImagePicker
  // Used by the Super Admin product image uploader.
  // ----------------------------------------------------------

  static Future<String> uploadProductImage(XFile image) async {
    try {
      final extension = image.name.split('.').last.toLowerCase();

      if (!allowedExtensions.contains(extension)) {
        throw Exception(
          'Unsupported image type. Please use JPG, JPEG, PNG, or WEBP.',
        );
      }

      final bytes = await image.readAsBytes();

      if (bytes.length > maxImageSize) {
        throw Exception('Image size must not exceed 2 MB.');
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${timestamp}_${image.name}';

      final ref = _storage
          .ref()
          .child('products')
          .child(fileName);

      final metadata = SettableMetadata(
        contentType: image.mimeType ?? _getMimeType(extension),
      );

      final task = await ref.putData(bytes, metadata);

      return await task.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception(
        'Firebase Storage error: ${e.message ?? e.code}',
      );
    } catch (e) {
      throw Exception(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  // ----------------------------------------------------------
  // Upload product image using product ID
  // Used by AdminProductProvider.
  // ----------------------------------------------------------

  static Future<String> uploadImage({
    required String productId,
    required String fileName,
    required Uint8List imageBytes,
  }) async {
    if (imageBytes.length > maxImageSize) {
      throw Exception('Image size must not exceed 2 MB.');
    }

    final extension = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : '';

    if (!allowedExtensions.contains(extension)) {
      throw Exception(
        'Unsupported image type. Please use JPG, JPEG, PNG, or WEBP.',
      );
    }

    final ref = _storage
        .ref()
        .child('products')
        .child(productId)
        .child(fileName);

    final metadata = SettableMetadata(
      contentType: _getMimeType(extension),
    );

    try {
      final task = await ref.putData(imageBytes, metadata);

      return await task.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception(
        'Firebase Storage error: ${e.message ?? e.code}',
      );
    }
  }

  // ----------------------------------------------------------
  // Upload multiple images
  // ----------------------------------------------------------

  static Future<List<String>> uploadProductImages(
    List<XFile> images,
  ) async {
    final urls = <String>[];

    for (final image in images) {
      urls.add(await uploadProductImage(image));
    }

    return urls;
  }

  // ----------------------------------------------------------
  // Delete single image
  // ----------------------------------------------------------

  static Future<void> deleteImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } on FirebaseException catch (e) {
      throw Exception(
        'Failed to delete image: ${e.message ?? e.code}',
      );
    }
  }

  // ----------------------------------------------------------
  // Delete all images belonging to a product
  // ----------------------------------------------------------

  static Future<void> deleteProductFolder(String productId) async {
    try {
      final folder = _storage
          .ref()
          .child('products')
          .child(productId);

      final result = await folder.listAll();

      for (final item in result.items) {
        await item.delete();
      }
    } on FirebaseException catch (e) {
      throw Exception(
        'Failed to delete product images: ${e.message ?? e.code}',
      );
    }
  }

  // ----------------------------------------------------------
  // Replace image
  // ----------------------------------------------------------

  static Future<String> replaceImage({
    required String oldImageUrl,
    required XFile newImage,
  }) async {
    await deleteImage(oldImageUrl);
    return await uploadProductImage(newImage);
  }

  // ----------------------------------------------------------
  // MIME type
  // ----------------------------------------------------------

  static String _getMimeType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }
}
