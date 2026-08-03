import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';

class ProductInventoryCard extends StatelessWidget {
  final ProductModel product;

  const ProductInventoryCard({
    super.key,
    required this.product,
  });

  Color get stockColor {
    if (product.stock <= 0) {
      return Colors.red;
    }

    if (product.stock < 20) {
      return Colors.orange;
    }

    return Colors.green;
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
              "Inventory",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text("Total Stock"),
              trailing: Text(
                "${product.stock}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: stockColor,
                ),
              ),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text("Rating"),
              trailing: Text(
                product.rating.toStringAsFixed(1),
              ),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.reviews_outlined),
              title: const Text("Reviews"),
              trailing: Text(
                "${product.reviewCount}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}