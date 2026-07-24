import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class PasswordCard extends StatelessWidget {
  const PasswordCard({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Password",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              const Icon(
                Icons.lock_outline,
                color: AppColors.primary,
                size: 28,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Text(
                  "************",
                  style: AppTextStyles.bodyLarge.copyWith(
                    letterSpacing: 2,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 25),

          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO
                // Navigate to Change Password Page
              },
              icon: const Icon(Icons.lock_reset_outlined),
              label: const Text("Change Password"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(
                  color: AppColors.primary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}