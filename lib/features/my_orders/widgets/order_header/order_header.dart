import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class OrdersHeader extends StatelessWidget {
  const OrdersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                "MY ORDERS",
                style: AppTextStyles.heading1.copyWith(
                  color: Colors.white,
                ),
              ),

            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Padding(
            padding: const EdgeInsets.only(left: 52),
            child: Text(
              "View and track all your previous purchases",
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.grey.shade400,
              ),
            ),
          ),

        ],
      ),
    );
  }
}