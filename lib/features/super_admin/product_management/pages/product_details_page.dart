import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../layout/admin_layout.dart';
import '/providers/product_management_provider.dart';

import '../widgets/product_gallery.dart';
import '../widgets/product_basic_information.dart';
import '../widgets/product_price_card.dart';
import '../widgets/product_inventory_card.dart';
import '../widgets/product_variant_table.dart';
import '../widgets/product_seo_card.dart';
import '../widgets/product_status_card.dart';
import '../widgets/product_action_buttons.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductManagementProvider>().loadProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    if (provider.isLoading) {
      return const AdminLayout(
        title: "Product Details",
        currentRoute: '/products',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.editingProduct == null) {
      return const AdminLayout(
        title: "Product Details",
        currentRoute: '/products',
        child: Center(child: Text("Product not found")),
      );
    }

    final product = provider.editingProduct!;

    return AdminLayout(
      title: product.name,
      currentRoute: '/products-details/${product.id}',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductGallery(product: product),

            const SizedBox(height: 24),

            ProductBasicInformation(product: product),

            const SizedBox(height: 24),

            ProductPriceCard(product: product),

            const SizedBox(height: 20),

            ProductInventoryCard(product: product),

            const SizedBox(height: 24),

            ProductVariantTable(product: product),

            const SizedBox(height: 24),

            ProductSeoCard(product: product),

            const SizedBox(height: 24),

            ProductStatusCard(product: product),

            const SizedBox(height: 32),

            ProductActionButtons(product: product),
          ],
        ),
      ),
    );
  }
}
