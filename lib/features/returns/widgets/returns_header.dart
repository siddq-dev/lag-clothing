import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

class ReturnsHeader extends StatelessWidget {
  const ReturnsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Returns & Refunds", style: AppTextStyles.heading2),

        const SizedBox(height: 12),

        const Text(
          "Shop with confidence. If your jersey doesn't fit or arrives damaged, "
          "our hassle-free return and refund policy ensures a smooth experience. "
          "Review the policies below before submitting a return request.",
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
