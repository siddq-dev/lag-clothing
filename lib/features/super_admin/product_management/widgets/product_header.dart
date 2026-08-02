import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({
    super.key,
    required this.onAddProduct,
  });

  final VoidCallback onAddProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Management",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Manage products, pricing, inventory, images and SEO.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),

        FilledButton.icon(
          onPressed: onAddProduct,
          icon: const Icon(Icons.add),
          label: const Text("Add Product"),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}