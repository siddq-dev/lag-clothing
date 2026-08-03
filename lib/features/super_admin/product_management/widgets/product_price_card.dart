import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductPriceCard
    extends StatelessWidget {
  final ProductModel product;

  const ProductPriceCard({
    super.key,
    required this.product,
  });

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
              "Pricing",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Divider(),

            ListTile(
              title:
                  const Text("Price"),
              trailing: Text(
                "₹${product.price.toStringAsFixed(2)}",
              ),
            ),

            ListTile(
              title: const Text(
                  "Sale Price"),
              trailing: Text(
                "₹${product.salePrice.toStringAsFixed(2)}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}