import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  FirebaseStorageService._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static const int maxImageSize = 2 * 1024 * 1024;

  static const List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

  //==========================================================
  // Upload Product Image
  //==========================================================

  static Future<String> uploadProductImage(XFile image) async {
    try {
      final extension = image.name.split('.').last.toLowerCase();

      if (!allowedExtensions.contains(extension)) {
        throw Exception(
          "Unsupported image type. Please use JPG, JPEG, PNG, or WEBP.",
        );
      }

      final bytes = await image.readAsBytes();

      if (bytes.length > maxImageSize) {
        throw Exception("Image size must not exceed 2 MB.");
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final fileName = "${timestamp}_${image.name}";

      final ref = _storage.ref().child("products").child(fileName);

      final metadata = SettableMetadata(
        contentType: image.mimeType ?? _getMimeType(extension),
      );

      final uploadTask = await ref.putData(bytes, metadata);

      return await uploadTask.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception("Firebase Storage error: ${e.message ?? e.code}");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  //==========================================================
  // Upload Multiple Images
  //==========================================================

  static Future<List<String>> uploadProductImages(List<XFile> images) async {
    final List<String> urls = [];

    for (final image in images) {
      final url = await uploadProductImage(image);

      urls.add(url);
    }

    return urls;
  }

  //==========================================================
  // Delete Image
  //==========================================================

  static Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);

      await ref.delete();
    } on FirebaseException catch (e) {
      throw Exception("Failed to delete image: ${e.message ?? e.code}");
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

      return await uploadProductImage(newImage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  //==========================================================
  // MIME Type
  //==========================================================

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
