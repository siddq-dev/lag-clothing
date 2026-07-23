import 'package:flutter/material.dart';

import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CheckoutSummary extends StatefulWidget {
  const CheckoutSummary({super.key});

  @override
  State<CheckoutSummary> createState() => _CheckoutSummaryState();
}

class _CheckoutSummaryState extends State<CheckoutSummary> {
  bool agreeTerms = false;

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
            "Checkout",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.lg),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [

                Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "Your payment information is encrypted and secure.",
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 25),

          CheckboxListTile(
            value: agreeTerms,
            activeColor: AppColors.primary,
            controlAffinity:
                ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "I agree to the Terms & Conditions and Privacy Policy.",
            ),
            onChanged: (value) {
              setState(() {
                agreeTerms = value!;
              });
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: agreeTerms
                  ? () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.orderConfirmation,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Place Order",
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.cart,
                );
              },
              child: const Text(
                "Back to Cart",
              ),
            ),
          ),

        ],
      ),
    );
  }
}