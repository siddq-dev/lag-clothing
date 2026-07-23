import 'package:flutter/material.dart';

import '../../../../models/feature_product_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.product,
    required this.quantity,
  });

  final ProductModel product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
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

          /// Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              product.image,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          /// Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  product.club,
                  style: AppTextStyles.heading3,
                ),

                const SizedBox(height: 6),

                Text(
                  product.title,
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 10),

                const Text(
                  "Size : XL",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [

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
                            onPressed: () {},
                            icon: const Icon(Icons.remove),
                          ),

                          Text(
                            quantity.toString(),
                            style: AppTextStyles.bodyLarge,
                          ),

                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          ),

                        ],
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "₹${product.price.toStringAsFixed(0)}",
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                TextButton.icon(
                  onPressed: () {},
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