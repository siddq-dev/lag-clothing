import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class ConfirmationHeader extends StatelessWidget {
  const ConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxxl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [

          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            "ORDER CONFIRMED",
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.bodyLarge,
              children: [

                const TextSpan(
                  text: "Thank You For Shopping With ",
                ),

                TextSpan(
                  text: "LAG CLOTHING",
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 15),

          Text(
            "Your order has been placed successfully.\nWe'll notify you once it starts shipping.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),

        ],
      ),
    );
  }
}