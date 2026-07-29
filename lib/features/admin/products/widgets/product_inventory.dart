import 'package:flutter/material.dart';

import '../../../../models/product_form_model.dart';

class ProductInventory extends StatelessWidget {
  const ProductInventory({
    super.key,
    required this.form,
  });

  final ProductFormModel form;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: TextFormField(
          keyboardType:
              TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Total Stock",
          ),
          onChanged: (value) {
            form.stock =
                int.tryParse(value) ?? 0;
          },
        ),
      ),
    );
  }
}