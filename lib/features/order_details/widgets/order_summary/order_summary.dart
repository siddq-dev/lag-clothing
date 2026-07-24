import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  final double subtotal;
  final double shipping;
  final double discount;
  final double total;

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
            "Order Summary",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          _summaryRow(
            "Subtotal",
            "₹${subtotal.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 18),

          _summaryRow(
            "Shipping",
            shipping == 0
                ? "FREE"
                : "₹${shipping.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 18),

          _summaryRow(
            "Discount",
            "- ₹${discount.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 25),

          Divider(
            color: AppColors.border,
          ),

          const SizedBox(height: 25),

          _summaryRow(
            "Total",
            "₹${total.toStringAsFixed(0)}",
            isTotal: true,
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