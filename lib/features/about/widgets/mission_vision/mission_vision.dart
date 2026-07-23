import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class MissionVision extends StatelessWidget {
  const MissionVision({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 100,
      ),
      child: Column(
        children: [

          Text(
            'OUR MISSION & VISION',
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 20),

          const SizedBox(
            width: 700,
            child: Text(
              'The purpose that inspires us every day and the vision that guides our future.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge,
            ),
          ),

          const SizedBox(height: 70),

          Row(
            children: const [

              Expanded(
                child: MissionVisionCard(
                  icon: Icons.flag_outlined,
                  title: 'Our Mission',
                  description:
                      'To provide premium-quality football jerseys that allow every fan to proudly represent their club, country, and passion while delivering exceptional value and customer experience.',
                ),
              ),

              SizedBox(width: 30),

              Expanded(
                child: MissionVisionCard(
                  icon: Icons.visibility_outlined,
                  title: 'Our Vision',
                  description:
                      'To become one of India’s most trusted football jersey brands by combining innovation, authenticity, and quality while building a community of passionate football supporters.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MissionVisionCard extends StatelessWidget {
  const MissionVisionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            size: 48,
            color: AppColors.primary,
          ),

          const SizedBox(height: 24),

          Text(
            title,
            style: AppTextStyles.heading2,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}