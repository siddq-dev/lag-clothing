import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class Journey extends StatelessWidget {
  const Journey({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 100,
      ),
      color: AppColors.surface,
      child: Column(
        children: [

          Text(
            'OUR JOURNEY',
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 20),

          const SizedBox(
            width: 700,
            child: Text(
              'Every great journey begins with a dream. Here are the milestones that shaped LAG Clothing.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge,
            ),
          ),

          const SizedBox(height: 80),

          Row(
            children: const [

              Expanded(
                child: JourneyItem(
                  year: '2026',
                  title: 'Four Friends Started LAG Clothing',
                ),
              ),

              Expanded(
                child: JourneyItem(
                  year: '2026',
                  title: 'First Jersey Collection Designed',
                ),
              ),

              Expanded(
                child: JourneyItem(
                  year: '2027',
                  title: 'Official Website Launch',
                ),
              ),

              Expanded(
                child: JourneyItem(
                  year: 'Future',
                  title: 'Global Expansion',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class JourneyItem extends StatelessWidget {
  const JourneyItem({
    super.key,
    required this.year,
    required this.title,
  });

  final String year;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          year,
          style: AppTextStyles.heading3,
        ),

        const SizedBox(height: 12),

        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}