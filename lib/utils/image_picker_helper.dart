import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static Future<List<Uint8List>> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );

    if (result == null) {
      return [];
    }

    return result.files
        .where((file) => file.bytes != null)
        .map((file) => file.bytes!)
        .toList();
  }
}
