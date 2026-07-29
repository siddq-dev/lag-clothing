import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
    required this.salePrice,
  });

  final double price;
  final double salePrice;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = salePrice < price;

    return Row(
      children: [
        Text(
          "₹${salePrice.toStringAsFixed(0)}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        if (hasDiscount) ...[
          const SizedBox(width: 8),

          Text(
            "₹${price.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}