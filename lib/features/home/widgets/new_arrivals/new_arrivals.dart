import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/product_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_text_style.dart';
import '../../../../widgets/products/home_product_card.dart';
import '../../../../widgets/products/product_section_animation.dart';

class NewArrivals extends StatelessWidget {
  const NewArrivals({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    final products = provider.newArrivals;

    return ProductSectionAnimation(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
        child: Column(
          children: [
            // ==================================================
            // TITLE
            // ==================================================
            const Text(
              'New Arrivals',
              style: AppTextStyles.sectionTitle,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            const Text(
              'Fresh arrivals from our latest collection.',
              style: AppTextStyles.sectionSubtitle,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 50),

            // ==================================================
            // PRODUCTS
            // ==================================================
            if (provider.loading && products.isEmpty)
              const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (products.isEmpty)
              const SizedBox(
                height: 200,
                child: Center(child: Text('No new arrivals available.')),
              )
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  int crossAxisCount;
                  double spacing;
                  double childAspectRatio;

                  if (width < 600) {
                    // PHONE
                    crossAxisCount = 2;
                    spacing = 10;
                    childAspectRatio = 0.72;
                  } else if (width < 1024) {
                    // TABLET
                    crossAxisCount = 3;
                    spacing = 18;
                    childAspectRatio = 0.75;
                  } else {
                    // DESKTOP
                    crossAxisCount = 4;
                    spacing = 24;
                    childAspectRatio = 0.80;
                  }

                  final displayProducts = products.length > 4
                      ? products.take(4).toList()
                      : products;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      return HomeProductCard(product: displayProducts[index]);
                    },
                  );
                },
              ),

            const SizedBox(height: 35),

            // ==================================================
            // VIEW MORE
            // ==================================================
            OutlinedButton(
              onPressed: () {
                context.go(AppRouter.shop);
              },
              child: const Text('View More'),
            ),
          ],
        ),
      ),
    );
  }
}
