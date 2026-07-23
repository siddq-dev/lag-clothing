import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CouponBox extends StatelessWidget {
  const CouponBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Coupon Code",
          style: AppTextStyles.bodyLarge,
        ),

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

      ],
    );
  }
}