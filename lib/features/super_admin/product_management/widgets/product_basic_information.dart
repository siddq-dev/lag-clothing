import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductBasicInformation
    extends StatelessWidget {
  final ProductModel product;

  const ProductBasicInformation({
    super.key,
    required this.product,
  });

  Widget row(
      String title,
      String value,
      ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Basic Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Divider(),

            row(
              "Product Name",
              product.name,
            ),

            row(
              "Brand",
              product.brand,
            ),

            row(
              "Category",
              product.category,
            ),

            row(
              "Sub Category",
              product.subCategory,
            ),

            const SizedBox(height: 10),

            const Text(
              "Description",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(product.description),
          ],
        ),
      ),
    );
  }
}