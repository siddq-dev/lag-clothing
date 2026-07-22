import 'package:flutter/material.dart';

import 'package:lag_clothing/themes/app_colors.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: 450,
          height: 450,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.image_outlined,
              size: 100,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}