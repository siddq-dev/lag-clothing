import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class CheckoutProductList extends StatelessWidget {
  const CheckoutProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final checkout = context.watch<CheckoutProvider>().checkout;

    if (checkout == null || checkout.cartItems.isEmpty) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          ...checkout.cartItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _CheckoutProductItem(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutProductItem extends StatelessWidget {
  const _CheckoutProductItem({required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    final hasSize = item.size.trim().isNotEmpty;

    final hasColor = item.color.trim().isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.productImage,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 90,
                height: 90,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.productName, style: AppTextStyles.heading3),

              const SizedBox(height: 8),

              if (hasSize)
                Text('Size: ${item.size}', style: AppTextStyles.bodyMedium),

              if (hasColor) ...[
                const SizedBox(height: 4),
                Text('Color: ${item.color}', style: AppTextStyles.bodyMedium),
              ],

              const SizedBox(height: 8),

              Text(
                'Quantity: ${item.quantity}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${item.price.toStringAsFixed(2)}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              '₹${item.total.toStringAsFixed(2)}',
              style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }
}
