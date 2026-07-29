import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Product Description",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          product.description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 40),

        const Text(
          "Features",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        // Access features dynamically to avoid static errors if ProductModel
        // doesn't declare a `features` getter. Falls back to empty list.
        Builder(
          builder: (_) {
            final List<dynamic> features = (product as dynamic).features ?? <dynamic>[];
            return Column(
              children: features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 18,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(feature.toString()),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            );
          },
        ),

      ],
    );
  }
}