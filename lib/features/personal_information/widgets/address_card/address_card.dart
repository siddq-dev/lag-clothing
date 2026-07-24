import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

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
            "Default Shipping Address",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 28,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "John Doe",
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "123 ABC Street",
                      style: AppTextStyles.bodyMedium,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Chennai",
                      style: AppTextStyles.bodyMedium,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Tamil Nadu - 600001",
                      style: AppTextStyles.bodyMedium,
                    ),

                  ],
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
                // Navigate to Saved Addresses
              },
              icon: const Icon(Icons.edit_location_alt_outlined),
              label: const Text("Edit Address"),
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