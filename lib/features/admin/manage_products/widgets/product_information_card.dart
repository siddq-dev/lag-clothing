import 'package:flutter/material.dart';

import '../../../../../models/product_model.dart';

class ProductInformationCard extends StatelessWidget {
  const ProductInformationCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(product.brand, style: theme.textTheme.titleMedium),

            const SizedBox(height: 25),

            Wrap(
              spacing: 40,
              runSpacing: 20,
              children: [
                _infoTile(
                  "Category",
                  "${product.category} / ${product.subCategory}",
                ),

                _infoTile("Price", "₹${product.price}"),

                _infoTile("Sale Price", "₹${product.salePrice}"),

                _infoTile("Stock", product.stock.toString()),

                _infoTile("Rating", "${product.rating} ⭐"),

                _infoTile("Reviews", product.reviewCount.toString()),
              ],
            ),

            const SizedBox(height: 35),

            Row(
              children: [
                _statusChip(
                  "Status",
                  product.status ? Colors.green : Colors.red,
                ),

                const SizedBox(width: 12),

                if (product.featured) _statusChip("Featured", Colors.blue),

                const SizedBox(width: 12),

                if (product.bestSeller)
                  _statusChip("Best Seller", Colors.orange),

                const SizedBox(width: 12),

                if (product.newArrival)
                  _statusChip("New Arrival", Colors.purple),
              ],
            ),

            const SizedBox(height: 35),

            Text("Description", style: theme.textTheme.titleLarge),

            const SizedBox(height: 10),

            Text(product.description, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 6),

          Text(value),
        ],
      ),
    );
  }

  Widget _statusChip(String text, Color color) {
    return Chip(
      backgroundColor: color.withValues(alpha: 0.15),
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
