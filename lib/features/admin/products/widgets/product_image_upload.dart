import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../utils/image_picker_helper.dart';

class ProductImageUpload extends StatefulWidget {
  const ProductImageUpload({
    super.key,
    required this.onImagesSelected,
  });

  final ValueChanged<List<Uint8List>> onImagesSelected;

  @override
  State<ProductImageUpload> createState() =>
      _ProductImageUploadState();
}

class _ProductImageUploadState
    extends State<ProductImageUpload> {
  final List<Uint8List> _images = [];

  Future<void> _pickImages() async {
    final files =
        await ImagePickerHelper.pickImages();

    if (files.isEmpty) return;

    setState(() {
      _images.addAll(files);
    });

    widget.onImagesSelected(_images);
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });

    widget.onImagesSelected(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Product Images",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.upload),
              label: const Text(
                "Select Images",
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                _images.length,
                (index) {
                  return Stack(
                    children: [

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),
                        child: Image.memory(
                          _images[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        right: 0,
                        child: InkWell(
                          onTap: () =>
                              _removeImage(index),
                          child: Container(
                            decoration:
                                const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding:
                                  EdgeInsets.all(4),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}