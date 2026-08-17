import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';

import '/providers/product_management_provider.dart';

import '../widgets/product_header.dart';
import '../widgets/product_statistics.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/recent_products_table.dart';

import '../../dashboard/widgets/super_admin_sidebar.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  bool _isMobileSidebarOpen = false;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final provider = context.read<ProductManagementProvider>();

      provider.listenProducts();
      provider.loadStatistics();
    });
  }

  // ============================================================
  // MOBILE SIDEBAR
  // ============================================================

  void _openMobileSidebar() {
    setState(() {
      _isMobileSidebarOpen = true;
    });
  }

  void _closeMobileSidebar() {
    if (!mounted) return;

    setState(() {
      _isMobileSidebarOpen = false;
    });
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> _refreshProducts() async {
    final provider = context.read<ProductManagementProvider>();

    provider.listenProducts();
    provider.loadStatistics();
  }

  // ============================================================
  // ADD PRODUCT
  // ============================================================

  Future<void> _addProduct() async {
    await context.push(AppRouter.addProduct);

    if (!mounted) return;

    final provider = context.read<ProductManagementProvider>();

    provider.listenProducts();
    provider.loadStatistics();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;

    if (isMobile) {
      return _buildMobile();
    }

    return _buildDesktop();
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop() {
    final provider = context.watch<ProductManagementProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // ========================================================
          // SIDEBAR
          // ========================================================
          const SizedBox(
            width: 260,
            child: SuperAdminSidebar(currentRoute: AppRouter.manageProducts),
          ),

          // ========================================================
          // MAIN CONTENT
          // ========================================================
          Expanded(
            child: Container(
              color: Colors.black,
              child: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : _buildDesktopContent(provider),
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
    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // HEADER
            // ======================================================
            ProductHeader(onAddProduct: _addProduct),

            const SizedBox(height: 30),

            // ======================================================
            // STATISTICS
            // ======================================================
            ProductStatistics(provider: provider),

            const SizedBox(height: 30),

            // ======================================================
            // SEARCH
            // ======================================================
            const ProductSearchBar(),

            const SizedBox(height: 20),

            // ======================================================
            // CATEGORY
            // ======================================================
            CategoryFilter(
              value: 'All',
              onChanged: (value) {
                // TODO: connect provider filter.
              },
            ),

            const SizedBox(height: 30),

            // ======================================================
            // TABLE
            // ======================================================
            RecentProductsTable(
              products: provider.products,
              onDelete: provider.deleteProduct,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    final provider = context.watch<ProductManagementProvider>();

    return Scaffold(
      backgroundColor: Colors.black,

      // ==========================================================
      // MOBILE APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          tooltip: 'Menu',
          icon: const Icon(Icons.menu),
          onPressed: _openMobileSidebar,
        ),

        title: const Text(
          'Product Management',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _refreshProducts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: Stack(
        children: [
          // ========================================================
          // MAIN CONTENT
          // ========================================================
          provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                )
              : SafeArea(
                  child: RefreshIndicator(
                    onRefresh: _refreshProducts,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ----------------------------------------
                          // PAGE TITLE + ADD
                          // ----------------------------------------
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Products',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              ElevatedButton.icon(
                                onPressed: _addProduct,
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Add Product'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 11,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ----------------------------------------
                          // STATISTICS
                          // ----------------------------------------
                          ProductStatistics(provider: provider),

                          const SizedBox(height: 20),

                          // ----------------------------------------
                          // SEARCH
                          // ----------------------------------------
                          const Text(
                            'Search Products',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const ProductSearchBar(),

                          const SizedBox(height: 16),

                          // ----------------------------------------
                          // CATEGORY
                          // ----------------------------------------
                          const Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          CategoryFilter(
                            value: 'All',
                            onChanged: (value) {
                              // TODO: connect provider filter.
                            },
                          ),

                          const SizedBox(height: 20),

                          // ----------------------------------------
                          // PRODUCTS TABLE
                          // ----------------------------------------
                          RecentProductsTable(
                            products: provider.products,
                            onDelete: provider.deleteProduct,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

          // ========================================================
          // MOBILE SIDEBAR
          // ========================================================
          if (_isMobileSidebarOpen)
            Positioned.fill(
              child: Row(
                children: [
                  // ==================================================
                  // SIDEBAR
                  // ==================================================
                  SizedBox(
                    width: 280,
                    child: Material(
                      color: Colors.black,
                      elevation: 12,
                      child: SafeArea(
                        child: SuperAdminSidebar(
                          isMobile: true,

                          // THIS MAKES MANAGE PRODUCTS RED.
                          currentRoute: AppRouter.manageProducts,

                          onClose: _closeMobileSidebar,
                        ),
                      ),
                    ),
                  ),

                  // ==================================================
                  // OVERLAY
                  // ==================================================
                  Expanded(
                    child: GestureDetector(
                      onTap: _closeMobileSidebar,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
