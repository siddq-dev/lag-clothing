// cart_item.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cart_item_model.dart';
import '../../../../providers/cart_provider.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});

  final CartItemModel item;

  static const double _stackBreakpoint = 480;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < _stackBreakpoint;

        final image = ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.productImage,
            width: isNarrow ? double.infinity : 130,
            height: isNarrow ? 180 : 130,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: isNarrow ? double.infinity : 130,
                height: isNarrow ? 180 : 130,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 40),
              );
            },
          ),
        );

        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.productName, style: AppTextStyles.heading3),

            const SizedBox(height: 10),

            Text(
              'Size : ${item.size.trim().isEmpty ? '-' : item.size}',
              style: AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 6),

            Text(
              'Color : ${item.color.trim().isEmpty ? '-' : item.color}',
              style: AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 15),

            Text(
              '₹${item.price.toStringAsFixed(2)} each',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // QUANTITY + TOTAL
            // Wrap instead of Row+Spacer so it never overflows
            // on narrow widths; stacks naturally if needed.
            // ==================================================
            Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Decrease quantity',
                        onPressed: item.quantity > 1
                            ? () async {
                                final success = await cartProvider
                                    .decreaseQuantity(item);
                                if (!context.mounted) return;
                                if (!success && cartProvider.error != null) {
                                  _showMessage(context, cartProvider.error!);
                                }
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          item.quantity.toString(),
                          style: AppTextStyles.bodyLarge,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Increase quantity',
                        onPressed: () async {
                          final success = await cartProvider.increaseQuantity(
                            item,
                          );
                          if (!context.mounted) return;
                          if (!success && cartProvider.error != null) {
                            _showMessage(context, cartProvider.error!);
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),

                Text(
                  '₹${item.total.toStringAsFixed(2)}',
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextButton.icon(
              onPressed: () async {
                final success = await cartProvider.removeItem(item.id);
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Item removed from cart'
                          : (cartProvider.error ?? 'Failed to remove item'),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.lg),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image,
                    const SizedBox(height: AppSpacing.lg),
                    details,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image,
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(child: details),
                  ],
                ),
        );
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}