import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import 'package:lag_clothing/providers/product_provider.dart';

import '../widgets/product_grid.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.shop,
      child: const Padding(
        padding: EdgeInsets.all(40),
        child: ProductGrid(),
      ),
    );
  }
}