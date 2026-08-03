import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductSeoCard extends StatelessWidget {
  final ProductModel product;

  const ProductSeoCard({
    super.key,
    required this.product,
  });

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
              "SEO Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text("SEO Title : ${product.seo.seoTitle}"),

            const SizedBox(height: 10),

            Text(
              "Meta Description : ${product.seo.metaDescription}",
            ),

            const SizedBox(height: 10),

            Text("Slug : ${product.seo.slug}"),
          ],
        ),
      ),
    );
  }
}