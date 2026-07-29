import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),

        const SizedBox(width: 4),

        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}