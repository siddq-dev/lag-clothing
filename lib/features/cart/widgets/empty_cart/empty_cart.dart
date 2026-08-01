import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 60,
        ),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 550,
          ),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 100,
                color: Colors.grey,
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                "Your Cart is Empty",
                style: AppTextStyles.heading1,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                "Looks like you haven't added any jerseys to your cart yet.\nBrowse our latest collections and start shopping.",
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xxl),

              FilledButton.icon(
                onPressed: () {
                  context.go(AppRouter.shop);
                },
                icon: const Icon(Icons.storefront),
                label: const Text("Continue Shopping"),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}