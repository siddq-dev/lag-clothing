import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lag_clothing/providers/product_provider.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    if (provider.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.products.isEmpty) {
      return const Center(
        child: Text(
          "No Products Found",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.products.length,
      gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        childAspectRatio: .68,
      ),
      itemBuilder: (_, index) {
        return ProductCard(
          product: provider.products[index],
        );
      },
    );
  }
}