import 'package:flutter/material.dart';

import '../../../../models/cart_models.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class OrderReview extends StatelessWidget {
  const OrderReview({
    super.key,
    required this.cartItems,
  });

  final List<CartProduct> cartItems;

  @override
  Widget build(BuildContext context) {
    final int totalItems = cartItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    final double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

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
            "Order Review",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 25),

          ...cartItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
  item.product.image,
  width: 70,
  height: 70,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.white54,
      ),
    );
  },
),
),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          item.product.club,
                          style: AppTextStyles.heading3,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          item.product.title,
                          style: AppTextStyles.bodyMedium,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Qty : ${item.quantity}",
                          style: AppTextStyles.bodySmall,
                        ),

                      ],
                    ),
                  ),

                  Text(
                    "₹${(item.product.price * item.quantity).toStringAsFixed(0)}",
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 40),

          _summaryRow(
            "Items ($totalItems)",
            "₹${subtotal.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 12),

          _summaryRow(
            "Shipping",
            shipping == 0
                ? "FREE"
                : "₹${shipping.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 12),

          _summaryRow(
            "Discount",
            "- ₹${discount.toStringAsFixed(0)}",
          ),

          const Divider(height: 35),

          _summaryRow(
            "Total",
            "₹${total.toStringAsFixed(0)}",
            isTotal: true,
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