import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

import 'review_data.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.review,
  });

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage(review.image),
        ),

        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            review.rating.toInt(),
            (_) => const Icon(
              Icons.star,
              color: Colors.amber,
              size: 22,
            ),
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: 850,
          child: Text(
            '"${review.review}"',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge,
          ),
        ),

        const SizedBox(height: 32),

        Text(
          review.name,
          style: AppTextStyles.heading3,
        ),

        const SizedBox(height: 6),

        Text(
          review.designation,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}