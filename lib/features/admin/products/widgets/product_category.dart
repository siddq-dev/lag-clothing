import 'package:flutter/material.dart';

import '../../../../models/product_form_model.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({
    super.key,
    required this.form,
  });

  final ProductFormModel form;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Category",
              ),
              onChanged: (value) =>
                  form.category = value,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Sub Category",
              ),
              onChanged: (value) =>
                  form.subCategory = value,
            ),

          ],
        ),
      ),
    );
  }
}