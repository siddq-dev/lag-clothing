import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/section_sizes.dart';
import '../../../../providers/product_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../widgets/products/product_card.dart';

class FeaturedCollection extends StatelessWidget {
  const FeaturedCollection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    final products = provider.featuredProducts;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(
        children: [
          const Text('Featured Collection', style: AppTextStyles.sectionTitle),

          const SizedBox(height: 16),

          const Text(
            'Our hand-picked premium jerseys.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          if (provider.loading && products.isEmpty)
            const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (products.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(child: Text('No featured products available.')),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length > 4 ? 4 : products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onTap: () {
                    context.go('${AppRouter.shopProductDetails}/${product.id}');
                  },
                );
              },
            ),
          const SizedBox(height: 35),

          OutlinedButton(
            onPressed: () {
              context.go(AppRouter.shop);
            },
            child: const Text('View More'),
          ),
        ],
      ),
    );
  }
}
