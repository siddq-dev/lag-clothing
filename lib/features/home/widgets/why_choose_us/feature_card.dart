import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

import 'feature_data.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.feature,
  });

  final FeatureData feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            feature.icon,
            size: 48,
            color: AppColors.primary,
          ),

          const SizedBox(height: 24),

          Text(
            feature.title,
            style: AppTextStyles.heading3,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            feature.description,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}