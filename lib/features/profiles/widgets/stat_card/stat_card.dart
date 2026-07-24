import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  final String title;
  final String count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 135,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 30,
              color: AppColors.primary,
            ),

            const SizedBox(height: 12),

            Text(
              count,
              style: AppTextStyles.heading2.copyWith(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.grey.shade400,
              ),
            ),

          ],
        ),
      ),
    );
  }
}