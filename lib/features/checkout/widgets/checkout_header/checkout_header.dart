import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        children: [

          Text(
            "Secure Checkout",
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            "Complete your order by providing shipping and payment details.",
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.xxl),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              _step(
                title: "Cart",
                active: false,
                completed: true,
              ),

              _line(),

              _step(
                title: "Checkout",
                active: true,
                completed: false,
              ),

              _line(),

              _step(
                title: "Complete",
                active: false,
                completed: false,
              ),

            ],
          ),

        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      width: 80,
      height: 2,
      color: Colors.grey.shade700,
    );
  }

  Widget _step({
    required String title,
    required bool active,
    required bool completed,
  }) {
    Color color = Colors.grey;

    if (completed) {
      color = Colors.green;
    } else if (active) {
      color = AppColors.primary;
    }

    return Column(
      children: [

        CircleAvatar(
          radius: 18,
          backgroundColor: color,
          child: completed
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                )
              : Container(),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color,
          ),
        ),

      ],
    );
  }
}