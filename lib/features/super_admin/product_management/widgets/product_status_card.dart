import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';

class ProductStatusCard extends StatelessWidget {
  final ProductModel product;

  const ProductStatusCard({
    super.key,
    required this.product,
  });

  Widget buildChip(
    String text,
    bool enabled,
  ) {
    return Chip(
      backgroundColor:
          enabled ? Colors.green : Colors.grey.shade300,
      label: Text(
        text,
        style: TextStyle(
          color: enabled ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Status",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                buildChip(
                  "Active",
                  product.status,
                ),

                buildChip(
                  "Featured",
                  product.featured,
                ),

                buildChip(
                  "Best Seller",
                  product.bestSeller,
                ),

                buildChip(
                  "New Arrival",
                  product.newArrival,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}