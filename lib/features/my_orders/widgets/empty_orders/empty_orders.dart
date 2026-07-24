import 'package:flutter/material.dart';

import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppSpacing.xxl),
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

            Icon(
              Icons.inventory_2_outlined,
              size: 90,
              color: AppColors.primary,
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              "No Orders Yet",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              "Looks like you haven't placed any order yet.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge,
            ),

            const SizedBox(height: AppSpacing.xxl),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.shop,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text("Shop Now"),
            ),

          ],
        ),
      ),
    );
  }
}