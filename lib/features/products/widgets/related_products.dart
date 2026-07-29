import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../providers/product_provider.dart';

import 'product_card.dart';

class RelatedProducts extends StatelessWidget {
  const RelatedProducts({
    super.key,
    required this.currentProduct,
  });

  final ProductModel currentProduct;

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ProductProvider>();

    final related = provider.products
        .where(
          (product) =>
              product.category ==
                  currentProduct.category &&
              product.id != currentProduct.id,
        )
        .take(4)
        .toList();

    if (related.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        const Text(
          "Related Products",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 30),

        GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),

          itemCount: related.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            childAspectRatio: .68,
          ),

          itemBuilder: (_, index) {
            return ProductCard(
              product: related[index],
            );
          },
        ),

      ],
    );
  }
}