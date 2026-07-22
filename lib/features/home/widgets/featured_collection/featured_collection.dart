import 'package:flutter/material.dart';

import '../../../../core/constants/section_sizes.dart';
import '../../../../models/feature_product_model.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../widgets/products/product_card.dart';

class FeaturedCollection extends StatelessWidget {
  const FeaturedCollection({super.key});

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
            'Featured Collection',
            style: AppTextStyles.sectionTitle,
          ),

          const SizedBox(height: 16),

          const Text(
            'Our hand-picked premium jerseys.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featuredProducts.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.58,
            ),
            itemBuilder: (context, index) {
              final product = featuredProducts[index];

              return SizedBox(
                height: SectionSizes.productCardHeight,
                child: ProductCard(
                  product: product,

                  onTap: () {
                    // TODO:
                    // Product Details Page
                  },

                  onAddToCart: () {
                    // TODO:
                    // Add to Cart
                  },

                  onWishlist: () {
                    // TODO:
                    // Wishlist
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}