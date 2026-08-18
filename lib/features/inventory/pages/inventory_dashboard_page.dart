import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';

import '/providers/inventory_provider.dart';

import '../../../features/super_admin/dashboard/widgets/super_admin_sidebar.dart';

import '../widgets/inventory_summary_cards.dart';
import '../widgets/inventory_search_bar.dart';
import '../widgets/inventory_filter_bar.dart';
import '../widgets/inventory_table.dart';

class InventoryDashboardPage extends StatefulWidget {
  const InventoryDashboardPage({super.key});

  @override
  State<InventoryDashboardPage> createState() => _InventoryDashboardPageState();
}

class _InventoryDashboardPageState extends State<InventoryDashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  bool _isMobileSidebarOpen = false;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<InventoryProvider>().loadInventory();
    });
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  Future<void> _refreshInventory() async {
    await context.read<InventoryProvider>().loadInventory();
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
    final provider = context.watch<InventoryProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // ========================================================
          // DESKTOP SIDEBAR
          // ========================================================
          const SizedBox(
            width: 260,
            child: SuperAdminSidebar(currentRoute: AppRouter.inventory),
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

  Widget _buildDesktopContent(InventoryProvider provider) {
    return RefreshIndicator(
      color: Colors.red,
      backgroundColor: const Color(0xFF1A1A1A),
      onRefresh: _refreshInventory,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // HEADER
            // ======================================================
            _buildDesktopHeader(),

            const SizedBox(height: 30),

            // ======================================================
            // SUMMARY CARDS
            //
            // InventorySummaryCards automatically uses its
            // desktop layout here.
            // ======================================================
            InventorySummaryCards(provider: provider),

            const SizedBox(height: 30),

            // ======================================================
            // SEARCH
            // ======================================================
            InventorySearchBar(controller: _searchController),

            const SizedBox(height: 20),

            // ======================================================
            // FILTER
            // ======================================================
            const InventoryFilterBar(),

            const SizedBox(height: 30),

            // ======================================================
            // TABLE
            // ======================================================
            InventoryTable(products: provider.search(_searchController.text)),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP HEADER
  // ============================================================

  Widget _buildDesktopHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inventory Management',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Manage product inventory and stock levels.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),

        IconButton(
          tooltip: 'Refresh inventory',
          onPressed: _refreshInventory,
          icon: const Icon(Icons.refresh, color: Colors.white),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    final provider = context.watch<InventoryProvider>();

    return Scaffold(
      backgroundColor: Colors.black,

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          tooltip: 'Menu',
          onPressed: _openMobileSidebar,
          icon: const Icon(Icons.menu, color: Colors.white),
        ),

        title: const Text(
          'Inventory',
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
            onPressed: _refreshInventory,
            icon: const Icon(Icons.refresh, color: Colors.white),
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
                    color: Colors.red,
                    backgroundColor: const Color(0xFF1A1A1A),
                    onRefresh: _refreshInventory,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ========================================
                          // MOBILE HEADER
                          // ========================================
                          _buildMobileHeader(),

                          const SizedBox(height: 20),

                          // ========================================
                          // MOBILE SUMMARY CARDS
                          //
                          // The InventorySummaryCards widget
                          // automatically switches to:
                          //
                          // Row 1:
                          // Products + In Stock
                          //
                          // Row 2:
                          // Low Stock + Out of Stock
                          //
                          // Row 3:
                          // Inventory Value
                          // ========================================
                          InventorySummaryCards(provider: provider),

                          const SizedBox(height: 20),

                          // ========================================
                          // SEARCH
                          // ========================================
                          const Text(
                            'Search Inventory',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          InventorySearchBar(controller: _searchController),

                          const SizedBox(height: 16),

                          // ========================================
                          // FILTER
                          // ========================================
                          const InventoryFilterBar(),

                          const SizedBox(height: 20),

                          // ========================================
                          // TABLE
                          // ========================================
                          _buildMobileTable(provider),
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
                          currentRoute: AppRouter.inventory,
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

  // ============================================================
  // MOBILE HEADER
  // ============================================================

  Widget _buildMobileHeader() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inventory',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Manage stock and inventory.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE TABLE
  // ============================================================

  Widget _buildMobileTable(InventoryProvider provider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        color: const Color(0xFF151515),
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 650),
            child: InventoryTable(
              products: provider.search(_searchController.text),
            ),
          ),
        ),
      ),
    );
  }
}
