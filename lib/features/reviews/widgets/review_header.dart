import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

class ReviewHeader extends StatelessWidget {
  const ReviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Customer Reviews", style: AppTextStyles.heading2),

        const SizedBox(height: 12),

        const Text(
          "Read genuine reviews from customers who purchased this jersey. "
          "Share your own experience to help other football fans make the right choice.",
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
