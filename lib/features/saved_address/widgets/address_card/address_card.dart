import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.addressType,
    required this.name,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.pincode,
    this.isDefault = false,
    required this.onEdit,
    required this.onDelete,
  });

  final String addressType;
  final String name;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;

  final bool isDefault;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  IconData get addressIcon {
    switch (addressType.toLowerCase()) {
      case "home":
        return Icons.home_outlined;

      case "office":
        return Icons.business_outlined;

      default:
        return Icons.location_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xl),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Address Type
          Row(
            children: [

              Icon(
                addressIcon,
                color: AppColors.primary,
              ),

              const SizedBox(width: 10),

              Text(
                addressType,
                style: AppTextStyles.heading3,
              ),

              const Spacer(),

              if (isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Default",
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            name,
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 6),

          Text(
            phone,
            style: AppTextStyles.bodyLarge,
          ),

          const SizedBox(height: 12),

          Text(
            addressLine1,
            style: AppTextStyles.bodyLarge,
          ),

          if (addressLine2.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                addressLine2,
                style: AppTextStyles.bodyLarge,
              ),
            ),

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

          const SizedBox(height: AppSpacing.xl),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                label: const Text("Edit"),
              ),

              const SizedBox(width: 12),

              OutlinedButton.icon(
                onPressed: onDelete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                icon: const Icon(Icons.delete_outline),
                label: const Text("Delete"),
              ),

            ],
          ),

        ],
      ),
    );
  }
}