import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/feature_product_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../widgets/products/product_card.dart';

class NewArrivals extends StatelessWidget {
  const NewArrivals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Column(
        children: [
          const Text(
            'New Arrivals',
            style: AppTextStyles.sectionTitle,
          ),

          const SizedBox(height: 16),

          const Text(
            'Fresh arrivals from our latest collection.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: newArrivalProducts.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.48,
            ),
            itemBuilder: (context, index) {
              final product = newArrivalProducts[index];

              return Column(
                children: [
                  Expanded(
                    child: ProductCard(
                      product: product,

                      onTap: () {},

                      onAddToCart: () {
                        context.go(AppRouter.cart);
                      },

                      onWishlist: () {
                        context.go(AppRouter.wishlist);
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.go(AppRouter.shop);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.primary,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        "Explore More",
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}