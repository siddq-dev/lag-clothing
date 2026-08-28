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

  static const double _stackBreakpoint = 480;

  @override
  Widget build(BuildContext context) {
    final hasSize = item.size.trim().isNotEmpty;

    final hasColor = item.color.trim().isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < _stackBreakpoint;

        final image = ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.productImage,
            width: isNarrow ? double.infinity : 90,
            height: isNarrow ? 160 : 90,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: isNarrow ? double.infinity : 90,
                height: isNarrow ? 160 : 90,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey,
                ),
              );
            },
          ),
        );

        final details = Column(
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
        );

        final priceBlock = isNarrow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${item.price.toStringAsFixed(2)} each',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '₹${item.total.toStringAsFixed(2)}',
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              )
            : Column(
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
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image,
              const SizedBox(height: 14),
              details,
              const SizedBox(height: 12),
              priceBlock,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            const SizedBox(width: 18),
            Expanded(child: details),
            const SizedBox(width: 15),
            priceBlock,
          ],
        );
      },
    );
  }
}
