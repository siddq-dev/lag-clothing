import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/checkout_payment_method_model.dart';
import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckoutProvider>();

    final selected = provider.checkout?.paymentMethod;

    final hasSelection = selected != null && selected.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: hasSelection ? AppColors.border : Colors.red.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Method *', style: AppTextStyles.heading3),

          const SizedBox(height: 8),

          Text(
            'Select a payment method to continue.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 18),

          ...checkoutPaymentMethods.map((method) {
            return RadioListTile<String?>(
              contentPadding: EdgeInsets.zero,
              value: method.id,
              groupValue: selected,
              title: Text(method.title, style: AppTextStyles.bodyLarge),
              onChanged: (value) => provider.selectPayment(value ?? ''),
            );
          }),

          if (!hasSelection)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Please select a payment method.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
