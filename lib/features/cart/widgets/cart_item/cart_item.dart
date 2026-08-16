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

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // PRODUCT IMAGE
          // ======================================================
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.productImage,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 130,
                  height: 130,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, size: 40),
                );
              },
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          // ======================================================
          // PRODUCT DETAILS
          // ======================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------------------------------------------------
                // PRODUCT NAME
                // --------------------------------------------------
                Text(item.productName, style: AppTextStyles.heading3),

                const SizedBox(height: 10),

                // --------------------------------------------------
                // SELECTED SIZE
                // --------------------------------------------------
                Text(
                  'Size : ${item.size.trim().isEmpty ? '-' : item.size}',
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 6),

                // --------------------------------------------------
                // SELECTED COLOR
                // --------------------------------------------------
                Text(
                  'Color : ${item.color.trim().isEmpty ? '-' : item.color}',
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 15),

                // --------------------------------------------------
                // UNIT PRICE
                // --------------------------------------------------
                Text(
                  '₹${item.price.toStringAsFixed(2)} each',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // QUANTITY + TOTAL
                // ==================================================
                Row(
                  children: [
                    // ------------------------------------------------
                    // QUANTITY CONTROLS
                    // ------------------------------------------------
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // --------------------------------------------
                          // DECREASE
                          // --------------------------------------------
                          IconButton(
                            tooltip: 'Decrease quantity',
                            onPressed: item.quantity > 1
                                ? () async {
                                    final success = await cartProvider
                                        .decreaseQuantity(item);

                                    if (!context.mounted) {
                                      return;
                                    }

                                    if (!success &&
                                        cartProvider.error != null) {
                                      _showMessage(
                                        context,
                                        cartProvider.error!,
                                      );
                                    }
                                  }
                                : null,
                            icon: const Icon(Icons.remove),
                          ),

                          // --------------------------------------------
                          // QUANTITY
                          // --------------------------------------------
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              item.quantity.toString(),
                              style: AppTextStyles.bodyLarge,
                            ),
                          ),

                          // --------------------------------------------
                          // INCREASE
                          // --------------------------------------------
                          IconButton(
                            tooltip: 'Increase quantity',
                            onPressed: () async {
                              final success = await cartProvider
                                  .increaseQuantity(item);

                              if (!context.mounted) {
                                return;
                              }

                              if (!success && cartProvider.error != null) {
                                _showMessage(context, cartProvider.error!);
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ------------------------------------------------
                    // TOTAL
                    // ------------------------------------------------
                    Text(
                      '₹${item.total.toStringAsFixed(2)}',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ==================================================
                // REMOVE
                // ==================================================
                TextButton.icon(
                  onPressed: () async {
                    final success = await cartProvider.removeItem(item.id);

                    if (!context.mounted) {
                      return;
                    }

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
                  label: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
