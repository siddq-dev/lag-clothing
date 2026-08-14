import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lag_clothing/routes/app_routes.dart';
import 'package:lag_clothing/themes/app_colors.dart';
import 'package:lag_clothing/themes/app_text_style.dart';

class HeroButtons extends StatelessWidget {
  const HeroButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 12,
      children: [
        // ============================================================
        // SHOP NOW
        // ============================================================
        ElevatedButton(
          onPressed: () {
            context.go(AppRouter.shop);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Shop Now', style: AppTextStyles.button),
        ),

        // ============================================================
        // EXPLORE COLLECTION
        // ============================================================
        OutlinedButton(
          onPressed: () {
            context.go(AppRouter.shop);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Explore Collection',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
