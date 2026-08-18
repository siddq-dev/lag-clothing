import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/order_provider.dart';
import 'package:lag_clothing/providers/admin_order_filter_provider.dart';
import '../../../../models/order_model.dart';

import '../../../../routes/app_routes.dart';

import '../../../super_admin/dashboard/widgets/super_admin_sidebar.dart';

import '../widgets/admin_order_filter.dart';
import '../widgets/admin_order_search_bar.dart';
import '../widgets/admin_order_sort.dart';
import '../widgets/order_status_chip.dart';

class AdminManageOrdersPage extends StatefulWidget {
  const AdminManageOrdersPage({super.key});

  @override
  State<AdminManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<AdminManageOrdersPage> {
  late TextEditingController searchController;

  bool _isMobileSidebarOpen = false;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<OrderProvider>().fetchAllOrders();
    });
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    searchController.dispose();
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
  // FILTER DIALOG
  // ============================================================

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) => const Dialog(
        backgroundColor: Color(0xFF151515),
        child: Padding(padding: EdgeInsets.all(20), child: AdminOrderFilter()),
      ),
    );
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
    final orderProvider = context.watch<OrderProvider>();
    final filterProvider = context.watch<AdminOrderFilterProvider>();

    final orders = filterProvider.apply(orderProvider.orders);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // ========================================================
          // DESKTOP SIDEBAR
          // ========================================================
          const SizedBox(
            width: 260,
            child: SuperAdminSidebar(currentRoute: AppRouter.adminOrderDetails),
          ),

          // ========================================================
          // MAIN CONTENT
          // ========================================================
          Expanded(
            child: Container(
              color: Colors.black,
              child: _buildDesktopContent(
                orderProvider,
                filterProvider,
                orders,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP CONTENT
  // ============================================================

  Widget _buildDesktopContent(
    OrderProvider orderProvider,
    AdminOrderFilterProvider filterProvider,
    List<OrderModel> orders,
  ) {
    return RefreshIndicator(
      color: Colors.red,
      backgroundColor: const Color(0xFF1A1A1A),
      onRefresh: () async {
        await orderProvider.fetchAllOrders();
      },
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
            // SEARCH / SORT / FILTER
            // ======================================================
            _buildDesktopControls(filterProvider),

            const SizedBox(height: 30),

            // ======================================================
            // STATISTICS
            // ======================================================
            _buildDesktopStatistics(orders),

            const SizedBox(height: 30),

            // ======================================================
            // ORDERS TABLE
            // ======================================================
            SizedBox(
              height: 520,
              child: _buildOrdersContent(orderProvider, orders),
            ),
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
                'Manage Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Manage customer orders, payments and delivery status.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),

        IconButton(
          tooltip: 'Refresh orders',
          onPressed: () async {
            await context.read<OrderProvider>().fetchAllOrders();
          },
          icon: const Icon(Icons.refresh, color: Colors.white),
        ),
      ],
    );
  }

  // ============================================================
  // DESKTOP CONTROLS
  // ============================================================

  Widget _buildDesktopControls(AdminOrderFilterProvider filterProvider) {
    return Row(
      children: [
        // --------------------------------------------------------
        // SEARCH
        // --------------------------------------------------------
        Expanded(
          child: AdminOrderSearchBar(
            controller: searchController,
            onChanged: (value) {
              context.read<AdminOrderFilterProvider>().updateSearch(value);
            },
            onClear: () {
              searchController.clear();

              context.read<AdminOrderFilterProvider>().clearSearch();
            },
          ),
        ),

        const SizedBox(width: 16),

        // --------------------------------------------------------
        // SORT
        // --------------------------------------------------------
        AdminOrderSort(
          value: filterProvider.sortBy,
          onChanged: (value) {
            if (value != null) {
              context.read<AdminOrderFilterProvider>().updateSort(value);
            }
          },
        ),

        const SizedBox(width: 16),

        // --------------------------------------------------------
        // FILTER
        // --------------------------------------------------------
        _filterButton(),
      ],
    );
  }

  // ============================================================
  // FILTER BUTTON
  // ============================================================

  Widget _filterButton() {
    return SizedBox(
      height: 46,
      child: FilledButton.icon(
        onPressed: _showFilterDialog,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(Icons.filter_alt_outlined, size: 19),
        label: const Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP STATISTICS
  // ============================================================

  Widget _buildDesktopStatistics(List<OrderModel> orders) {
    final statistics = _calculateStatistics(orders);

    return Row(
      children: [
        Expanded(
          child: _statCard(
            title: 'Orders',
            value: statistics.totalOrders.toString(),
            color: Colors.blue,
            icon: Icons.shopping_bag_outlined,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _statCard(
            title: 'Pending',
            value: statistics.pendingOrders.toString(),
            color: Colors.orange,
            icon: Icons.pending_actions_outlined,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _statCard(
            title: 'Shipped',
            value: statistics.shippedOrders.toString(),
            color: Colors.indigo,
            icon: Icons.local_shipping_outlined,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _statCard(
            title: 'Delivered',
            value: statistics.deliveredOrders.toString(),
            color: Colors.green,
            icon: Icons.check_circle_outline,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _statCard(
            title: 'Revenue',
            value: '₹${statistics.revenue.toStringAsFixed(0)}',
            color: Colors.purple,
            icon: Icons.currency_rupee,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    final orderProvider = context.watch<OrderProvider>();
    final filterProvider = context.watch<AdminOrderFilterProvider>();

    final orders = filterProvider.apply(orderProvider.orders);

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
          'Orders',
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
            onPressed: () async {
              await orderProvider.fetchAllOrders();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: Stack(
        children: [
          orderProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                )
              : SafeArea(
                  child: RefreshIndicator(
                    color: Colors.red,
                    backgroundColor: const Color(0xFF1A1A1A),
                    onRefresh: () async {
                      await orderProvider.fetchAllOrders();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ========================================
                          // HEADER
                          // ========================================
                          _buildMobileHeader(),

                          const SizedBox(height: 20),

                          // ========================================
                          // SEARCH
                          // ========================================
                          const Text(
                            'Search Orders',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 10),

                          AdminOrderSearchBar(
                            controller: searchController,
                            onChanged: (value) {
                              context
                                  .read<AdminOrderFilterProvider>()
                                  .updateSearch(value);
                            },
                            onClear: () {
                              searchController.clear();

                              context
                                  .read<AdminOrderFilterProvider>()
                                  .clearSearch();
                            },
                          ),

                          const SizedBox(height: 12),

                          // ========================================
                          // SORT + FILTER
                          // ========================================
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 44,
                                  child: AdminOrderSort(
                                    value: filterProvider.sortBy,
                                    onChanged: (value) {
                                      if (value != null) {
                                        context
                                            .read<AdminOrderFilterProvider>()
                                            .updateSort(value);
                                      }
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: SizedBox(
                                  height: 44,
                                  child: _mobileFilterButton(),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ========================================
                          // STATISTICS
                          // ========================================
                          _buildMobileStatistics(orders),

                          const SizedBox(height: 20),

                          // ========================================
                          // ORDERS
                          // ========================================
                          _buildMobileOrders(orderProvider, orders),
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
                  SizedBox(
                    width: 280,
                    child: Material(
                      color: Colors.black,
                      elevation: 12,
                      child: SafeArea(
                        child: SuperAdminSidebar(
                          isMobile: true,
                          currentRoute: AppRouter.adminOrderDetails,
                          onClose: _closeMobileSidebar,
                        ),
                      ),
                    ),
                  ),

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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 5),

        Text(
          'Manage customer orders and delivery.',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE FILTER BUTTON
  // ============================================================

  Widget _mobileFilterButton() {
    return OutlinedButton.icon(
      onPressed: _showFilterDialog,
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF151515),
        foregroundColor: Colors.white70,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(Icons.filter_alt_outlined, size: 18),
      label: const Text(
        'Filters',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ============================================================
  // MOBILE STATISTICS
  // ============================================================

  Widget _buildMobileStatistics(List<OrderModel> orders) {
    final statistics = _calculateStatistics(orders);

    return Column(
      children: [
        // --------------------------------------------------------
        // ROW 1
        // --------------------------------------------------------
        Row(
          children: [
            Expanded(
              child: _statCard(
                title: 'Orders',
                value: statistics.totalOrders.toString(),
                color: Colors.blue,
                icon: Icons.shopping_bag_outlined,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _statCard(
                title: 'Pending',
                value: statistics.pendingOrders.toString(),
                color: Colors.orange,
                icon: Icons.pending_actions_outlined,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // ROW 2
        // --------------------------------------------------------
        Row(
          children: [
            Expanded(
              child: _statCard(
                title: 'Shipped',
                value: statistics.shippedOrders.toString(),
                color: Colors.indigo,
                icon: Icons.local_shipping_outlined,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _statCard(
                title: 'Delivered',
                value: statistics.deliveredOrders.toString(),
                color: Colors.green,
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // REVENUE
        // --------------------------------------------------------
        _mobileRevenueCard(value: '₹${statistics.revenue.toStringAsFixed(0)}'),
      ],
    );
  }

  // ============================================================
  // STATISTICS CARD
  // ============================================================

  Widget _statCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------------
          // ICON
          // ------------------------------------------------------
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),

          const Spacer(),

          // ------------------------------------------------------
          // TITLE + VALUE
          // ------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: 6),

              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: color,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE REVENUE CARD
  // ============================================================

  Widget _mobileRevenueCard({required String value}) {
    return Container(
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.currency_rupee,
              color: Colors.purple,
              size: 21,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Text(
              'Revenue',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDERS CONTENT
  // ============================================================

  Widget _buildOrdersContent(
    OrderProvider orderProvider,
    List<OrderModel> orders,
  ) {
    if (orderProvider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }

    if (orderProvider.error != null) {
      return Center(
        child: Text(
          orderProvider.error!,
          style: const TextStyle(color: Colors.white70),
        ),
      );
    }

    if (orders.isEmpty) {
      return _emptyOrders();
    }

    return _buildOrdersTable(orderProvider, orders);
  }

  // ============================================================
  // MOBILE ORDERS
  // ============================================================

  Widget _buildMobileOrders(
    OrderProvider orderProvider,
    List<OrderModel> orders,
  ) {
    if (orderProvider.isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    if (orderProvider.error != null) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            orderProvider.error!,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    if (orders.isEmpty) {
      return _emptyOrders();
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _ordersDataTable(orderProvider, orders),
      ),
    );
  }

  // ============================================================
  // ORDERS TABLE
  // ============================================================

  Widget _buildOrdersTable(
    OrderProvider orderProvider,
    List<OrderModel> orders,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _ordersDataTable(orderProvider, orders),
      ),
    );
  }

  // ============================================================
  // DATA TABLE
  // ============================================================

  DataTable _ordersDataTable(
    OrderProvider orderProvider,
    List<OrderModel> orders,
  ) {
    return DataTable(
      headingRowHeight: 58,
      dataRowHeight: 70,
      horizontalMargin: 20,
      columnSpacing: 28,

      headingTextStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),

      dataTextStyle: const TextStyle(color: Colors.white, fontSize: 13),

      columns: const [
        DataColumn(label: Text('Order ID')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Total')),
        DataColumn(label: Text('Payment')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Actions')),
      ],

      rows: orders.map((order) {
        return DataRow(
          cells: [
            // ----------------------------------------------------
            // ORDER ID
            // ----------------------------------------------------
            DataCell(
              Text(
                order.orderNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            // ----------------------------------------------------
            // CUSTOMER
            // ----------------------------------------------------
            DataCell(Text(order.shippingAddress.fullName)),

            // ----------------------------------------------------
            // DATE
            // ----------------------------------------------------
            DataCell(
              Text(
                order.createdAt == null
                    ? '-'
                    : order.createdAt!.toDate().toString().split(' ').first,
              ),
            ),

            // ----------------------------------------------------
            // TOTAL
            // ----------------------------------------------------
            DataCell(
              Text(
                '₹${order.total.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),

            // ----------------------------------------------------
            // PAYMENT
            // ----------------------------------------------------
            DataCell(Text(order.paymentMethod)),

            // ----------------------------------------------------
            // STATUS
            // ----------------------------------------------------
            DataCell(OrderStatusChip(status: order.orderStatus.name)),

            // ----------------------------------------------------
            // ACTIONS
            // ----------------------------------------------------
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'View order',
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      context.push(
                        '${AppRouter.adminOrderDetails}/${order.orderNumber}',
                        extra: order,
                      );
                    },
                  ),

                  IconButton(
                    tooltip: 'Mark as shipped',
                    icon: const Icon(
                      Icons.local_shipping_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: () async {
                      await orderProvider.updateOrderStatus(
                        order.id,
                        OrderStatus.shipped,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // ============================================================
  // EMPTY ORDERS
  // ============================================================

  Widget _emptyOrders() {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, color: Colors.white24, size: 42),

            SizedBox(height: 12),

            Text(
              'No Orders Found',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 5),

            Text(
              'Orders will appear here when customers place them.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STATISTICS CALCULATION
  // ============================================================

  _OrderStatistics _calculateStatistics(List<OrderModel> orders) {
    final totalOrders = orders.length;

    final pendingOrders = orders
        .where((e) => e.orderStatus == OrderStatus.placed)
        .length;

    final shippedOrders = orders
        .where(
          (e) =>
              e.orderStatus == OrderStatus.shipped ||
              e.orderStatus == OrderStatus.outForDelivery,
        )
        .length;

    final deliveredOrders = orders
        .where((e) => e.orderStatus == OrderStatus.delivered)
        .length;

    final revenue = orders
        .where((e) => e.paymentStatus == PaymentStatus.paid)
        .fold<double>(0, (sum, order) => sum + order.total);

    return _OrderStatistics(
      totalOrders: totalOrders,
      pendingOrders: pendingOrders,
      shippedOrders: shippedOrders,
      deliveredOrders: deliveredOrders,
      revenue: revenue,
    );
  }
}

// ============================================================
// ORDER STATISTICS MODEL
// ============================================================

class _OrderStatistics {
  const _OrderStatistics({
    required this.totalOrders,
    required this.pendingOrders,
    required this.shippedOrders,
    required this.deliveredOrders,
    required this.revenue,
  });

  final int totalOrders;
  final int pendingOrders;
  final int shippedOrders;
  final int deliveredOrders;
  final double revenue;
}
