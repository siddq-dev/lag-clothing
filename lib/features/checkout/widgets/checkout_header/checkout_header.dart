import 'package:flutter/material.dart';

import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Checkout",
          style: AppTextStyles.heading1,
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          "Complete your order securely.",
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}