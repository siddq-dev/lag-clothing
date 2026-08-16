import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final checkout = context.watch<CheckoutProvider>().checkout;

    if (checkout == null) {
      return const SizedBox();
    }

    final items = checkout.cartItems;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: AppTextStyles.heading3),

          const SizedBox(height: 24),

          Text(
            '${items.length} '
            '${items.length == 1 ? 'Product' : 'Products'}',
            style: AppTextStyles.bodyLarge,
          ),

          const SizedBox(height: 18),

          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('No products selected.'),
            )
          else
            ...items.map(_productItem),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 12),

          _row('Subtotal', checkout.subtotal),

          _row('Tax', checkout.tax),

          if (checkout.discount > 0) _row('Discount', -checkout.discount),

          const SizedBox(height: 8),

          const Divider(),

          const SizedBox(height: 8),

          _row('Total', checkout.grandTotal, isTotal: true),
        ],
      ),
    );
  }

  Widget _productItem(dynamic item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.network(
                item.productImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surface,
                    child: const Icon(Icons.image_not_supported_outlined),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                if (item.size.trim().isNotEmpty)
                  Text('Size: ${item.size}', style: AppTextStyles.bodyLarge),

                if (item.color.trim().isNotEmpty)
                  Text('Color: ${item.color}', style: AppTextStyles.bodyLarge),

                const SizedBox(height: 2),

                Text(
                  'Quantity: ${item.quantity}',
                  style: AppTextStyles.bodyLarge,
                ),

                const SizedBox(height: 8),

                Text(
                  '₹${item.total.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String title, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Text(
            title,
            style: isTotal ? AppTextStyles.heading3 : AppTextStyles.bodyLarge,
          ),

          const Spacer(),

          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: isTotal
                ? AppTextStyles.heading3.copyWith(color: AppColors.primary)
                : AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
