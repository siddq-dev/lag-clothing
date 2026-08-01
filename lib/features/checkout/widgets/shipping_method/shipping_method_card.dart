import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class ShippingMethodCard extends StatelessWidget {
  const ShippingMethodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<CheckoutProvider>();

    final selected =
        provider.checkout?.shippingMethod ??
            "standard";

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
            "Shipping Method",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 20),

          RadioListTile(
            value: "standard",
            groupValue: selected,
            title: const Text(
              "Standard Delivery",
            ),
            subtitle: const Text(
              "3 - 5 Days",
            ),
            onChanged: (_) {
              provider.selectShipping(
                "standard",
                100,
              );
            },
          ),

          RadioListTile(
            value: "express",
            groupValue: selected,
            title: const Text(
              "Express Delivery",
            ),
            subtitle: const Text(
              "1 - 2 Days",
            ),
            onChanged: (_) {
              provider.selectShipping(
                "express",
                250,
              );
            },
          ),

          RadioListTile(
            value: "free",
            groupValue: selected,
            title: const Text(
              "Free Delivery",
            ),
            subtitle: const Text(
              "5 - 7 Days",
            ),
            onChanged: (_) {
              provider.selectShipping(
                "free",
                0,
              );
            },
          ),
        ],
      ),
    );
  }
}