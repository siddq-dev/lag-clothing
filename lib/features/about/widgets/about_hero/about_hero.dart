import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class AboutHero extends StatelessWidget {
  const AboutHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 420,
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'ABOUT LAG CLOTHING',
              style: AppTextStyles.heading1.copyWith(
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: 700,
              child: Text(
                'More than jerseys. We create identity, passion, and pride for every football fan.',
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