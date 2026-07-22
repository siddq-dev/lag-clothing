import 'package:flutter/material.dart';

import '../../../../models/feature_product_model.dart';
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
              childAspectRatio: 0.58,
            ),
            itemBuilder: (context, index) {
              final product = newArrivalProducts[index];

              return ProductCard(
                product: product,
                onTap: () {},
                onAddToCart: () {},
                onWishlist: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}