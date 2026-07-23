import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';
import '../coupon_box/coupon_box.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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

          Text(
            "Order Summary",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          _summaryRow("Items (3)", "₹4,597"),

          const SizedBox(height: AppSpacing.md),

          _summaryRow("Shipping", "FREE"),

          const SizedBox(height: AppSpacing.md),

          _summaryRow("Discount", "- ₹200"),

          const Divider(height: 40),

          _summaryRow(
            "Total",
            "₹4,397",
            isTotal: true,
          ),

          const SizedBox(height: AppSpacing.xxl),

         const CouponBox(),

          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [

              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Coupon",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
                child: const Text("Apply"),
              ),

            ],
          ),

          const SizedBox(height: AppSpacing.xxl),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Proceed to Checkout",
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: isTotal
              ? AppTextStyles.heading3
              : AppTextStyles.bodyLarge,
        ),

        const Spacer(),

        Text(
          value,
          style: isTotal
              ? AppTextStyles.heading3.copyWith(
                  color: AppColors.primary,
                )
              : AppTextStyles.bodyLarge,
        ),

      ],
    );
  }
}