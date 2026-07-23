import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/shop_hero/shop_hero.dart';
import '../widgets/shop_sidebar/shop_sidebar.dart';
import '../widgets/shop_search/shop_search.dart';
import '../widgets/product_grid/shop_product_grid.dart';
import '../widgets/pagination/pagination.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.shop,
      child: const Column(
        children: [

          ShopHero(),

          _ShopBody(),

          Pagination(),

        ],
      ),
    );
  }
}

class _ShopBody extends StatelessWidget {
  const _ShopBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 260,
            child: ShopSidebar(),
          ),

          SizedBox(width: 40),

          Expanded(
            child: Column(
              children: [

                ShopSearch(),

                SizedBox(height: 40),

                ShopProductGrid(),

              ],
            ),
          ),

        ],
      ),
    );
  }
}