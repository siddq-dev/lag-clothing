import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO
              // Download Invoice PDF
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(
                color: AppColors.primary,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.download_outlined,
            ),
            label: const Text(
              "Download Invoice",
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.lg),

        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO
              // Buy Again
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart_checkout_outlined,
            ),
            label: const Text(
              "Buy Again",
            ),
          ),
        ),

      ],
    );
  }
}