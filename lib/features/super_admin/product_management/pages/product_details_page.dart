import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '/providers/product_management_provider.dart';

import '../../dashboard/widgets/super_admin_sidebar.dart';

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
      if (!mounted) return;

      context.read<ProductManagementProvider>().loadProduct(widget.productId);
    });
  }

  // ============================================================
  // BACK TO PRODUCT MANAGEMENT
  // ============================================================

  void _goBackToProducts() {
    context.go(AppRouter.manageProducts);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    if (isMobile) {
      return _buildMobile(provider);
    }

    return _buildDesktop(provider);
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop(ProductManagementProvider provider) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // --------------------------------------------------------
          // DESKTOP SIDEBAR
          // --------------------------------------------------------
          const SizedBox(width: 260, child: SuperAdminSidebar()),

          // --------------------------------------------------------
          // CONTENT
          // --------------------------------------------------------
          Expanded(
            child: Container(
              color: Colors.black,
              child: _buildDesktopContent(provider),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP CONTENT
  // ============================================================

  Widget _buildDesktopContent(ProductManagementProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }

    if (provider.editingProduct == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: Colors.grey,
            ),

            const SizedBox(height: 16),

            const Text(
              'Product not found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: _goBackToProducts,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Products'),
            ),
          ],
        ),
      );
    }

    final product = provider.editingProduct!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========================================================
          // DESKTOP HEADER
          // ========================================================
          Row(
            children: [
              IconButton(
                tooltip: 'Back to Product Management',
                onPressed: _goBackToProducts,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

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

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(ProductManagementProvider provider) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        // --------------------------------------------------------
        // BACK ARROW
        // --------------------------------------------------------
        leading: IconButton(
          tooltip: 'Back to Product Management',
          onPressed: _goBackToProducts,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),

        // --------------------------------------------------------
        // PAGE NAME
        // --------------------------------------------------------
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // No hamburger
        // No right-side action
        actions: const [],
      ),

      body: SafeArea(child: _buildMobileContent(provider)),
    );
  }

  // ============================================================
  // MOBILE CONTENT
  // ============================================================

  Widget _buildMobileContent(ProductManagementProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }

    if (provider.editingProduct == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.inventory_2_outlined,
                color: Colors.grey,
                size: 60,
              ),

              const SizedBox(height: 16),

              const Text(
                'Product not found',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: _goBackToProducts,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Products'),
              ),
            ],
          ),
        ),
      );
    }

    final product = provider.editingProduct!;

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================================
            // PRODUCT NAME
            // ========================================================
            Text(
              product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            // ========================================================
            // PRODUCT CONTENT
            // ========================================================
            ProductGallery(product: product),

            const SizedBox(height: 18),

            ProductBasicInformation(product: product),

            const SizedBox(height: 18),

            ProductPriceCard(product: product),

            const SizedBox(height: 18),

            ProductInventoryCard(product: product),

            const SizedBox(height: 18),

            ProductVariantTable(product: product),

            const SizedBox(height: 18),

            ProductSeoCard(product: product),

            const SizedBox(height: 18),

            ProductStatusCard(product: product),

            const SizedBox(height: 24),

            ProductActionButtons(product: product),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
