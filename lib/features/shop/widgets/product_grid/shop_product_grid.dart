import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/shop_provider.dart';
import '../shop_product_card/shop_product_card.dart';

class ShopProductGrid extends StatelessWidget {
  const ShopProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, provider, child) {
        // ==================================================
        // LOADING
        // ==================================================

        if (provider.isLoading && provider.products.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // ==================================================
        // ERROR
        // ==================================================

        if (provider.error != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),

                  const SizedBox(height: 16),

                  const Text(
                    'Unable to load products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: provider.loadProducts,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // ==================================================
        // EMPTY
        // ==================================================

        if (provider.products.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'No products found.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'There are currently no products available.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        // ==================================================
        // SCREEN WIDTH
        // ==================================================

        final width = MediaQuery.sizeOf(context).width;

        // ==================================================
        // RESPONSIVE GRID SETTINGS
        // ==================================================

        int crossAxisCount;
        double crossAxisSpacing;
        double mainAxisSpacing;
        double cardHeight;

        // --------------------------------------------------
        // PHONE
        // --------------------------------------------------

        if (width < 600) {
          crossAxisCount = 2;
          crossAxisSpacing = 10;
          mainAxisSpacing = 12;

          // At 390px screen width the product cards are
          // approximately 185px wide.
          //
          // We give them enough vertical space for:
          // image + brand + name + price + sizes + button.
          cardHeight = 455;
        }
        // --------------------------------------------------
        // TABLET
        // --------------------------------------------------
        else if (width < 1024) {
          crossAxisCount = 3;
          crossAxisSpacing = 18;
          mainAxisSpacing = 18;
          cardHeight = 470;
        }
        // --------------------------------------------------
        // SMALL DESKTOP
        // --------------------------------------------------
        else if (width < 1440) {
          crossAxisCount = 3;
          crossAxisSpacing = 22;
          mainAxisSpacing = 22;
          cardHeight = 500;
        }
        // --------------------------------------------------
        // LARGE DESKTOP
        // --------------------------------------------------
        else {
          crossAxisCount = 4;
          crossAxisSpacing = 24;
          mainAxisSpacing = 24;
          cardHeight = 520;
        }

        // ==================================================
        // PRODUCT GRID
        // ==================================================

        return GridView.builder(
          shrinkWrap: true,

          physics: const NeverScrollableScrollPhysics(),

          itemCount: provider.products.length,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,

            crossAxisSpacing: crossAxisSpacing,

            mainAxisSpacing: mainAxisSpacing,

            // ------------------------------------------------
            // FIXED CARD HEIGHT
            // ------------------------------------------------
            //
            // This prevents the yellow/black
            // "BOTTOM OVERFLOWED" warning.
            //
            // mainAxisExtent gives each card an explicit height
            // instead of calculating the height from its width.
            //
            mainAxisExtent: cardHeight,
          ),

          itemBuilder: (context, index) {
            final product = provider.products[index];

            return ShopProductCard(product: product);
          },
        );
      },
    );
  }
}
