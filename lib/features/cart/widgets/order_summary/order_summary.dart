import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../models/cart_item_model.dart';
import 'package:lag_clothing/services/checkout_validation_service.dart';
import '../../../../providers/cart_provider.dart';

import '../coupon_box/coupon_box.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.discount,
    required this.total,
  });

  final double subtotal;
  final double shipping;
  final double tax;
  final double discount;
  final double total;

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
            "Order Summary",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          _summaryRow(
            "Subtotal",
            "₹${subtotal.toStringAsFixed(2)}",
          ),

          const SizedBox(height: AppSpacing.md),

          _summaryRow(
            "Shipping",
            shipping == 0
                ? "FREE"
                : "₹${shipping.toStringAsFixed(2)}",
          ),

          const SizedBox(height: AppSpacing.md),

          _summaryRow(
            "Tax",
            "₹${tax.toStringAsFixed(2)}",
          ),

          const SizedBox(height: AppSpacing.md),

          _summaryRow(
            "Discount",
            "- ₹${discount.toStringAsFixed(2)}",
          ),

          const Divider(height: 40),

          _summaryRow(
            "Grand Total",
            "₹${total.toStringAsFixed(2)}",
            isTotal: true,
          ),

          const SizedBox(height: AppSpacing.xl),

          const CouponBox(),

          const SizedBox(height: AppSpacing.xl),

          SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton(
    onPressed: () async {
      final cartProvider = context.read<CartProvider>();

      final error = await CheckoutValidationService.validate(
        cartProvider,
      );

      if (!context.mounted) return;

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
        return;
      }

      context.go(AppRouter.checkout);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    child: const Text(
      "Proceed to Checkout",
    ),
  ),
),
         ]
          ),
        
      );
    
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: isTotal
              ? AppTextStyles.heading3
              : AppTextStyles.bodyLarge,
        ),

        const Spacer(),

        Text(
          value,
          style: isTotal
              ? AppTextStyles.heading3.copyWith(
                  color: AppColors.primary,
                )
              : AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}