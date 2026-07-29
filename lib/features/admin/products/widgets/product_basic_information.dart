import 'package:flutter/material.dart';

import '../../../../../models/product_form_model.dart';

class ProductBasicInformation extends StatelessWidget {
  const ProductBasicInformation({
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
                labelText: "Product Name",
              ),
              onChanged: (value) =>
                  form.name = value,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Brand",
              ),
              onChanged: (value) =>
                  form.brand = value,
            ),

            const SizedBox(height: 20),

            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
              onChanged: (value) =>
                  form.description = value,
            ),

          ],
        ),
      ),
    );
  }
}