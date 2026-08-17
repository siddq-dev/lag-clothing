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
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    // ------------------------------------------------------------
    // MOBILE
    // ------------------------------------------------------------

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            const ShopSearch(),

            const SizedBox(height: 16),

            // Mobile filter
            _MobileFilterButton(),

            const SizedBox(height: 24),

            const _ProductsContent(),
          ],
        ),
      );
    }

    // ------------------------------------------------------------
    // TABLET
    // ------------------------------------------------------------

    if (isTablet) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShopSearch(),

            const SizedBox(height: 24),

            const _ProductsContent(),
          ],
        ),
      );
    }

    // ------------------------------------------------------------
    // DESKTOP
    // ------------------------------------------------------------

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

                const _ProductsContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// PRODUCTS CONTENT
// ================================================================

class _ProductsContent extends StatelessWidget {
  const _ProductsContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, provider, child) {
        // --------------------------------------------------------
        // LOADING
        // --------------------------------------------------------

        if (provider.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // --------------------------------------------------------
        // ERROR
        // --------------------------------------------------------

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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(provider.error!, textAlign: TextAlign.center),

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

        // --------------------------------------------------------
        // EMPTY
        // --------------------------------------------------------

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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

        // --------------------------------------------------------
        // PRODUCT GRID
        // --------------------------------------------------------

        return const ShopProductGrid();
      },
    );
  }
}

// ================================================================
// MOBILE FILTER BUTTON
// ================================================================

class _MobileFilterButton extends StatelessWidget {
  const _MobileFilterButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.tune, size: 19),
        label: const Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const _MobileFilterSheet();
            },
          );
        },
      ),
    );
  }
}

// ================================================================
// MOBILE FILTER SHEET
// ================================================================

class _MobileFilterSheet extends StatelessWidget {
  const _MobileFilterSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            const SizedBox(height: 12),

            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Filter content
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: ShopSidebar(),
              ),
            ),

            // Apply button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
