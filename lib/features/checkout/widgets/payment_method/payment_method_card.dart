import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '/models/checkout_payment_method_model.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckoutProvider>();

    final selected =
        provider.checkout?.paymentMethod ?? "card";

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
            "Payment Method",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 20),

          ...checkoutPaymentMethods.map(
            (method) => RadioListTile<String>(
              value: method.id,
              groupValue: selected,
              title: Text(method.title),
              onChanged: (value) {
                if (value != null) {
                  provider.selectPayment(value);
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}