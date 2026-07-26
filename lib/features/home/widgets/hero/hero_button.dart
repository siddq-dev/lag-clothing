import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lag_clothing/routes/app_routes.dart';
import 'package:lag_clothing/themes/app_colors.dart';
import 'package:lag_clothing/themes/app_text_style.dart';

class HeroButtons extends StatelessWidget {
  const HeroButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ===========================
        // Shop Now Button
        // ===========================
        ElevatedButton(
          onPressed: () {
            context.go(AppRouter.shop);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Shop Now',
            style: AppTextStyles.button,
          ),
        ),

        const SizedBox(width: 16),

        // ===========================
        // Explore Collection Button
        // ===========================
        OutlinedButton(
          onPressed: () {
            context.go(AppRouter.shop);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Explore Collection',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}