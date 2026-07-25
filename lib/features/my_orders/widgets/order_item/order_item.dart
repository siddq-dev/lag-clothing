import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.image,
    required this.title,
    required this.quantity,
    required this.price,
  });

  final String image;
  final String title;
  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [

          /// Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          /// Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: AppTextStyles.heading3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                Text(
                  "Quantity : $quantity",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey.shade400,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          /// Price
          Text(
            "₹${price.toStringAsFixed(0)}",
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
            ),
          ),

        ],
      ),
    );
  }
}