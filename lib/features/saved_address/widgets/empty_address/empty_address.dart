import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class EmptyAddresses extends StatelessWidget {
  const EmptyAddresses({
    super.key,
    required this.onAddAddress,
  });

  final VoidCallback onAddAddress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: const Icon(
                Icons.location_on_outlined,
                size: 50,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              "No Saved Addresses",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              "Add your first delivery address to make checkout faster and easier.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            SizedBox(
              width: 220,
              child: ElevatedButton.icon(
                onPressed: onAddAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(
                  Icons.add_location_alt_outlined,
                ),
                label: const Text(
                  "Add Address",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}