import 'package:flutter/material.dart';

import '../../../../models/cart_models.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';
import '../coupon_box/coupon_box.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.cartItems,
  });

  final List<CartProduct> cartItems;

  @override
  Widget build(BuildContext context) {
    // Calculate total quantity
    final int totalItems = cartItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    // Calculate subtotal
    final double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    // Static values for now
    const double shipping = 0;
    const double discount = 200;

    final double total = subtotal + shipping - discount;

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
            "Items ($totalItems)",
            "₹${subtotal.toStringAsFixed(0)}",
          ),

          const SizedBox(height: AppSpacing.md),

          _summaryRow(
            "Shipping",
            shipping == 0
                ? "FREE"
                : "₹${shipping.toStringAsFixed(0)}",
          ),

          const SizedBox(height: AppSpacing.md),

          _summaryRow(
            "Discount",
            "- ₹${discount.toStringAsFixed(0)}",
          ),

          const Divider(height: 40),

          _summaryRow(
            "Total",
            "₹${total.toStringAsFixed(0)}",
            isTotal: true,
          ),

          const SizedBox(height: AppSpacing.xxl),

          const CouponBox(),

          const SizedBox(height: AppSpacing.xxl),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Checkout
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
        ],
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