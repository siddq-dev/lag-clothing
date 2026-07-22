import 'package:flutter/material.dart';

import '/core/constants/layout_constraints.dart';
import 'package:lag_clothing/themes/app_colors.dart';
import 'package:lag_clothing/themes/app_text_style.dart';
import 'hero_button.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

 @override
Widget build(BuildContext context) {
  return Expanded(
  child: Align(
    alignment: Alignment.centerLeft,
    child: ConstrainedBox(
      constraints: LayoutConstraints.text,
      child:SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Small Label
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'NEW ARRIVAL',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Main Heading
          const Text(
            'Premium Jerseys\nPerformance Meets Style',
            style: AppTextStyles.heroTitle,
          ),

          const SizedBox(height: 24),

          // Description
          const Text(
            'Discover premium-quality jerseys crafted for athletes, sports enthusiasts, and everyday comfort. Designed with performance, durability, and modern style in mind.',
            style: AppTextStyles.heroSubtitle,
          ),
          const SizedBox(height: 32),
          const HeroButtons(),
        ],
      ),
  )
  )
  )
  );
  }
}