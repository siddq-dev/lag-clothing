import 'package:flutter/material.dart';

import '/core/constants/layout_constraints.dart';
import 'package:lag_clothing/themes/app_colors.dart';
import 'package:lag_clothing/themes/app_text_style.dart';

import 'hero_button.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final bool isMobile = screenWidth < 700;

    return Align(
      alignment: isMobile ? Alignment.bottomLeft : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 70,
          vertical: isMobile ? 70 : 50,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? screenWidth - 48 : 650,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========================================================
                // LABEL
                // ========================================================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'NEW ARRIVAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ========================================================
                // TITLE
                // ========================================================
                Text(
                  'Premium Jerseys\nPerformance Meets Style',
                  style: AppTextStyles.heroTitle.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 36 : 58,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 20),

                // ========================================================
                // DESCRIPTION
                // ========================================================
                Text(
                  'Discover premium-quality jerseys crafted '
                  'for athletes, sports enthusiasts, and '
                  'everyday comfort. Designed with performance, '
                  'durability, and modern style in mind.',
                  style: AppTextStyles.heroSubtitle.copyWith(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: isMobile ? 14 : 17,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 30),

                // ========================================================
                // BUTTONS
                // ========================================================
                const HeroButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
