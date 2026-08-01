import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cart_item_model.dart';
import '../../../../providers/cart_provider.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.item,
  });

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
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------------------------
          // Product Image
          //--------------------------------------------------

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
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 40,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          //--------------------------------------------------
          // Product Details
          //--------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: AppTextStyles.heading3,
                ),

                const SizedBox(height: 10),

                Text(
                  "Size : ${item.size}",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 6),

                Text(
                  "Color : ${item.color}",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    //--------------------------------------------------
                    // Quantity Selector
                    //--------------------------------------------------

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await cartProvider.decreaseQuantity(item);
                            },
                            icon: const Icon(Icons.remove),
                          ),

                          Text(
                            item.quantity.toString(),
                            style: AppTextStyles.bodyLarge,
                          ),

                          IconButton(
                            onPressed: () async {
                              await cartProvider.increaseQuantity(item);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    //--------------------------------------------------
                    // Price
                    //--------------------------------------------------

                    Text(
                      "₹${item.total.toStringAsFixed(2)}",
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //--------------------------------------------------
                // Remove
                //--------------------------------------------------

                TextButton.icon(
                  onPressed: () async {
                    await cartProvider.removeItem(
                      item.productId,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Item removed from cart",
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Remove",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}