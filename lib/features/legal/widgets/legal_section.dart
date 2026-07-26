import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class LegalSection extends StatelessWidget {
  const LegalSection({
    super.key,
    required this.heading,
    required this.body,
  });

  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            heading,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            body,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}