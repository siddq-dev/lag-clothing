import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/shop_provider.dart';
import '../shop_product_card/shop_product_card.dart';

class ShopProductGrid extends StatelessWidget {
  const ShopProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, provider, child) {
        // Error
        if (provider.error != null) {
          return Center(
            child: Text(
              provider.error!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          );
        }

        // Empty
        if (provider.products.isEmpty) {
          return const Center(
            child: Text(
              "No products found.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        // Grid
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.products.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: .63,
          ),
          itemBuilder: (context, index) {
            final product = provider.products[index];

            return ShopProductCard(
              product: product,
            );
          },
        );
      },
    );
  }
}