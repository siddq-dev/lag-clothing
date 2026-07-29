import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductPreviewPage extends StatelessWidget {
  const ProductPreviewPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final image = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : "";

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Product Preview",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(30),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            if (image.isNotEmpty)

              ClipRRect(

                borderRadius:
                    BorderRadius.circular(20),

                child: Image.network(
                  image,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

              ),

            const SizedBox(height: 30),

            Text(
              product.brand,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.description,
            ),

            const SizedBox(height: 30),

            Text(
              "Price : ₹${product.salePrice}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Stock : ${product.stock}",
            ),

            const SizedBox(height: 20),

            Wrap(

              spacing: 10,

              children: product.variants.map((variant) {

                return Chip(

                  label: Text(
                    "${variant.size} • ${variant.color}",
                  ),

                );

              }).toList(),

            ),

            const SizedBox(height: 30),

            const Text(
              "SEO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.seo.seoTitle
            ),

            const SizedBox(height: 10),

            Text(
              product.seo.metaDescription,
            ),

            const SizedBox(height: 10),

            Text(
              product.seo.slug,
            ),

          ],

        ),

      ),

    );

  }
}