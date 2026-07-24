import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 180,
            child: Text(
              "Need Help",
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.grey.shade400,
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    const Icon(
                      Icons.email_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "support@lagclothing.com",
                      style: AppTextStyles.bodyLarge,
                    ),

                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [

                    const Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "+91 XXXXX XXXXX",
                      style: AppTextStyles.bodyLarge,
                    ),

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}