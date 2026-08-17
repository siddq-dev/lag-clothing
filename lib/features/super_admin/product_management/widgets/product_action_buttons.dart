import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductActionButtons extends StatelessWidget {
  final ProductModel product;

  const ProductActionButtons({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text("Edit"),
        ),

        const SizedBox(width: 15),

        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {},
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
        ),
      ],
    );
  }
}
