import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class CompanyStory extends StatelessWidget {
  const CompanyStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// LEFT SIDE
          Expanded(
            flex: 6,
            child: Container(
              height: 520,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/about/founders_group.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(width: 60),

          /// RIGHT SIDE
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'ABOUT LAG CLOTHING',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Built by Four Friends.\nInspired by Football.\nDriven by Passion.',
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 32),

                Text(
                  'LAG Clothing was born from the shared passion of four friends who believed football is more than just a game—it is an identity, a culture, and a way of bringing people together.',
                  style: AppTextStyles.bodyLarge,
                ),

                const SizedBox(height: 20),

                Text(
                  'What started as late-night conversations about football jerseys, design ideas, and the dream of building something meaningful soon evolved into LAG Clothing. Each friend brought unique strengths in creativity, technology, planning, and business to create one united vision.',
                  style: AppTextStyles.bodyLarge,
                ),

                const SizedBox(height: 20),

                Text(
                  'Our goal has always been to build more than an online jersey store. We wanted to create a place where every football fan could proudly wear jerseys that celebrate their clubs, countries, and unforgettable football memories.',
                  style: AppTextStyles.bodyLarge,
                ),

                const SizedBox(height: 20),

                Text(
                  'Today, LAG Clothing continues to grow with the same values it started with—quality, authenticity, innovation, and a genuine love for football. Every jersey represents our commitment to delivering products that fans can proudly wear both on and off the pitch.',
                  style: AppTextStyles.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}