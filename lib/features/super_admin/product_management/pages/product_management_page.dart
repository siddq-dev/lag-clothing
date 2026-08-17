import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lag_clothing/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../layout/admin_layout.dart';

import '/providers/product_management_provider.dart';

import '../widgets/product_header.dart';
import '../widgets/product_statistics.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/recent_products_table.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<ProductManagementProvider>();

      provider.listenProducts();
      provider.loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    return AdminLayout(
      title: 'Product Management',
      currentRoute: AppRouter.manageProducts,
      child: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductHeader(
                    onAddProduct: () async {
                      await context.push(AppRouter.addProduct);

                      if (context.mounted) {
                        final provider = context
                            .read<ProductManagementProvider>();

                        provider.listenProducts();
                        provider.loadStatistics();
                      }
                    },
                  ),

                  const SizedBox(height: 30),

                  ProductStatistics(provider: provider),

                  const SizedBox(height: 30),

                  const ProductSearchBar(),

                  const SizedBox(height: 20),

                  CategoryFilter(
                    value: "All",
                    onChanged: (value) {
                      // TODO: connect provider filter
                    },
                  ),

                  const SizedBox(height: 30),

                  RecentProductsTable(
                    products: provider.products,
                    onDelete: provider.deleteProduct,
                  ),
                ],
              ),
            ),
    );
  }
}
