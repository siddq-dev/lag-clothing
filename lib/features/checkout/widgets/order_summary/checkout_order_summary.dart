import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final checkout =
        context.watch<CheckoutProvider>().checkout;

    if (checkout == null) {
      return const SizedBox();
    }

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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            "Order Summary",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 25),

          _row(
            "Subtotal",
            checkout.subtotal,
          ),

          _row(
            "Shipping",
            checkout.shippingCharge,
          ),

          _row(
            "Tax",
            checkout.tax,
          ),

          _row(
            "Discount",
            -checkout.discount,
          ),

          const Divider(),

          _row(
            "Grand Total",
            checkout.grandTotal,
            isTotal: true,
          ),

        ],
      ),
    );
  }

  Widget _row(
    String title,
    double amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [

          Text(
            title,
            style: isTotal
                ? AppTextStyles.heading3
                : AppTextStyles.bodyLarge,
          ),

          const Spacer(),

          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: isTotal
                ? AppTextStyles.heading3.copyWith(
                    color: AppColors.primary,
                  )
                : AppTextStyles.bodyLarge,
          ),

        ],
      ),
    );
  }
}