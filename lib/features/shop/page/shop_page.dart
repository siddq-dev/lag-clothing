import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '/providers/shop_provider.dart';

import '../widgets/shop_hero/shop_hero.dart';
import '../widgets/shop_sidebar/shop_sidebar.dart';
import '../widgets/shop_search/shop_search.dart';
import '../widgets/product_grid/shop_product_grid.dart';
import '../widgets/pagination/pagination.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShopProvider()..loadProducts(),
      child: WebsiteLayout(
        currentRoute: AppRouter.shop,
        child: const Column(children: [ShopHero(), _ShopBody(), Pagination()]),
      ),
    );
  }
}

class _ShopBody extends StatelessWidget {
  const _ShopBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 260, child: ShopSidebar()),

          const SizedBox(width: 40),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShopSearch(),

                const SizedBox(height: 40),

                Consumer<ShopProvider>(
                  builder: (context, provider, child) {
                    // Loading
                    if (provider.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(60),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    // Error
                    if (provider.error != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(60),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error_outline, size: 50),
                              const SizedBox(height: 16),
                              const Text(
                                'Unable to load products',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                provider.error!,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => provider.loadProducts(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // No products
                    if (provider.products.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(60),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.inventory_2_outlined, size: 60),
                              SizedBox(height: 16),
                              Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'There are no products available at the moment.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // Products
                    return const ShopProductGrid();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
