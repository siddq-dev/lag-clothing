import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        children: [

          Text(
            "Shopping Cart",
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Review your selected jerseys before proceeding to checkout.",
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}