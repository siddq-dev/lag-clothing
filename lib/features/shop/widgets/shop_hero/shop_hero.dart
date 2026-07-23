import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class ShopHero extends StatelessWidget {
  const ShopHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'SHOP JERSEYS',
              style: AppTextStyles.heading1.copyWith(
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(
              width: 700,
              child: Text(
                'Explore premium football jerseys from clubs and national teams around the world.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge,
              ),
            ),

          ],
        ),
      ),
    );
  }
}