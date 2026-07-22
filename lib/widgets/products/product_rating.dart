import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

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
          size: 18,
          color: Colors.amber,
        ),

        const SizedBox(width: 4),

        Text(
          rating.toString(),
          style: const TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}