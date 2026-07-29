import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_form_model.dart';

import '../../../../providers/admin_product_provider.dart';

class SaveProductButton extends StatelessWidget {
  const SaveProductButton({
    super.key,
    required this.form,
    required this.images,
  });

  final ProductFormModel form;

  final List<Uint8List> images;

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<AdminProductProvider>();

    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: provider.loading
          ? const CircularProgressIndicator()
          : const Text("Save Product"),
      onPressed: provider.loading
          ? null
          : () async {
              await provider.saveProduct(
                form: form,
                images: images,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Product Uploaded Successfully",
                    ),
                  ),
                );
              }
            },
    );
  }
}