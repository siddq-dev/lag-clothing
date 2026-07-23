import 'package:flutter/material.dart';

import '../../../../models/feature_product_model.dart';
import '../shop_product_card/shop_product_card.dart';

class ShopProductGrid extends StatelessWidget {
  const ShopProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        int crossAxisCount = 4;

        if (constraints.maxWidth < 700) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1000) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 1400) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shopProducts.length,

          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.68,
          ),

          itemBuilder: (context, index) {

            final product = shopProducts[index];

        return ShopProductCard(
  product: product,
);
          },
        );
      },
    );
  }
}