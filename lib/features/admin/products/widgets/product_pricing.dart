import 'package:flutter/material.dart';

import '../../../../models/product_form_model.dart';

class ProductPricing extends StatelessWidget {
  const ProductPricing({
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
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
              ),
              onChanged: (value) {
                form.price =
                    double.tryParse(value) ?? 0;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              keyboardType:
                  TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Sale Price",
              ),
              onChanged: (value) {
                form.salePrice =
                    double.tryParse(value) ?? 0;
              },
            ),

          ],
        ),
      ),
    );
  }
}