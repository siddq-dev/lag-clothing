import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class ShippingInformation extends StatelessWidget {
  const ShippingInformation({
    super.key,
    required this.name,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.pincode,
  });

  final String name;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;

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
            "Shipping Information",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

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
                      name,
                      style: AppTextStyles.heading3,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      addressLine1,
                      style: AppTextStyles.bodyLarge,
                    ),

                    if (addressLine2.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        addressLine2,
                        style: AppTextStyles.bodyLarge,
                      ),
                    ],

                    const SizedBox(height: 4),

                    Text(
                      "$city, $state",
                      style: AppTextStyles.bodyLarge,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      pincode,
                      style: AppTextStyles.bodyLarge,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [

                        const Icon(
                          Icons.phone_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          phone,
                          style: AppTextStyles.bodyLarge,
                        ),

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}