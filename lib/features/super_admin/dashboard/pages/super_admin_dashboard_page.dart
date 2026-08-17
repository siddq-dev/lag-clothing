import 'package:flutter/material.dart';

import '/repositories/super_admin_dashboard_repository.dart';
import '../widgets/super_admin_sidebar.dart';

class SuperAdminDashboardPage extends StatefulWidget {
  const SuperAdminDashboardPage({super.key});

  @override
  State<SuperAdminDashboardPage> createState() =>
      _SuperAdminDashboardPageState();
}

class _SuperAdminDashboardPageState extends State<SuperAdminDashboardPage> {
  late Future<Map<String, int>> _statisticsFuture;

  bool _isMobileSidebarOpen = false;

  @override
  void initState() {
    super.initState();

    _loadStatistics();
  }

  // ============================================================
  // LOAD DASHBOARD DATA
  // ============================================================

  void _loadStatistics() {
    _statisticsFuture = SuperAdminDashboardRepository.getDashboardStatistics();
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> _refresh() async {
    setState(() {
      _loadStatistics();
    });

    await _statisticsFuture;
  }

  // ============================================================
  // OPEN MOBILE SIDEBAR
  // ============================================================

  void _openMobileSidebar() {
    setState(() {
      _isMobileSidebarOpen = true;
    });
  }

  // ============================================================
  // CLOSE MOBILE SIDEBAR
  // ============================================================

  void _closeMobileSidebar() {
    setState(() {
      _isMobileSidebarOpen = false;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ======================================================
          // DESKTOP
          // ======================================================
          if (!isMobile)
            Row(
              children: [
                const SuperAdminSidebar(),

                Expanded(
                  child: _buildDashboardContent(context, isMobile: false),
                ),
              ],
            ),

          // ======================================================
          // MOBILE
          // ======================================================
          if (isMobile) _buildDashboardContent(context, isMobile: true),

          // ======================================================
          // MOBILE SIDEBAR BACKDROP
          // ======================================================
          if (isMobile && _isMobileSidebarOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMobileSidebar,
                child: Container(color: Colors.black.withValues(alpha: 0.70)),
              ),
            ),

          // ======================================================
          // MOBILE SIDEBAR
          // ======================================================
          if (isMobile && _isMobileSidebarOpen)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 270,
                child: Material(
                  color: Colors.black,
                  child: SafeArea(
                    child: SuperAdminSidebar(onClose: _closeMobileSidebar),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // DASHBOARD CONTENT
  // ============================================================

  Widget _buildDashboardContent(
    BuildContext context, {
    required bool isMobile,
  }) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // HEADER
            // ==================================================
            if (isMobile) _buildMobileHeader() else _buildDesktopHeader(),

            SizedBox(height: isMobile ? 22 : 30),

            // ==================================================
            // STATISTICS
            // ==================================================
            Expanded(
              child: FutureBuilder<Map<String, int>>(
                future: _statisticsFuture,
                builder: (context, snapshot) {
                  // =================================================
                  // LOADING
                  // =================================================

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  // =================================================
                  // ERROR
                  // =================================================

                  if (snapshot.hasError) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 50,
                              color: Colors.red,
                            ),

                            const SizedBox(height: 15),

                            const Text(
                              'Unable to load dashboard data.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                snapshot.error.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),

                            const SizedBox(height: 20),

                            FilledButton.icon(
                              onPressed: _refresh,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // =================================================
                  // NO DATA
                  // =================================================

                  final data = snapshot.data;

                  if (data == null) {
                    return const Center(
                      child: Text(
                        'No dashboard data available.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  // =================================================
                  // VALUES
                  // =================================================

                  final totalAdmins = data['admins'] ?? 0;

                  final totalProducts = data['products'] ?? 0;

                  final totalCustomers = data['customers'] ?? 0;

                  final totalOrders = data['orders'] ?? 0;

                  // =================================================
                  // DASHBOARD CARDS
                  // =================================================

                  return _buildDashboardCards(
                    totalAdmins: totalAdmins,
                    totalProducts: totalProducts,
                    totalCustomers: totalCustomers,
                    totalOrders: totalOrders,
                    isMobile: isMobile,
                  );
                },
              ),
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
      children: [
        const Expanded(
          child: Text(
            'Super Admin Dashboard',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        IconButton(
          tooltip: 'Refresh',
          onPressed: _refresh,
          icon: const Icon(Icons.refresh, size: 28, color: Colors.white),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE HEADER
  // ============================================================

  Widget _buildMobileHeader() {
    return Row(
      children: [
        // --------------------------------------------------------
        // HAMBURGER
        // --------------------------------------------------------
        IconButton(
          tooltip: 'Menu',
          onPressed: _openMobileSidebar,
          icon: const Icon(Icons.menu, color: Colors.white, size: 28),
        ),

        const SizedBox(width: 2),

        // --------------------------------------------------------
        // LOGO
        // --------------------------------------------------------
        const Text(
          'LAG Clothing',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(width: 12),

        // --------------------------------------------------------
        // DASHBOARD TITLE
        // --------------------------------------------------------
        const Expanded(
          child: Text(
            'Super Admin Dashboard',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // --------------------------------------------------------
        // REFRESH
        // --------------------------------------------------------
        IconButton(
          tooltip: 'Refresh',
          onPressed: _refresh,
          icon: const Icon(Icons.refresh, color: Colors.white, size: 22),
        ),
      ],
    );
  }

  // ============================================================
  // DASHBOARD CARDS
  // ============================================================

  Widget _buildDashboardCards({
    required int totalAdmins,
    required int totalProducts,
    required int totalCustomers,
    required int totalOrders,
    required bool isMobile,
  }) {
    final cards = [
      _DashboardCard(
        title: 'Total Admins',
        value: totalAdmins.toString(),
        icon: Icons.admin_panel_settings,
      ),

      _DashboardCard(
        title: 'Products',
        value: totalProducts.toString(),
        icon: Icons.shopping_bag,
      ),

      _DashboardCard(
        title: 'Customers',
        value: totalCustomers.toString(),
        icon: Icons.people,
      ),

      _DashboardCard(
        title: 'Orders',
        value: totalOrders.toString(),
        icon: Icons.receipt_long,
      ),
    ];

    // ==========================================================
    // MOBILE
    // 2 CARDS PER ROW
    // ==========================================================

    if (isMobile) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: cards.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.15,
        ),

        itemBuilder: (context, index) {
          return cards[index];
        },
      );
    }

    // ==========================================================
    // DESKTOP
    // 4 CARDS IN ONE ROW
    // ==========================================================

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: cards[0]),

        const SizedBox(width: 20),

        Expanded(child: cards[1]),

        const SizedBox(width: 20),

        Expanded(child: cards[2]),

        const SizedBox(width: 20),

        Expanded(child: cards[3]),
      ],
    );
  }
}

// ================================================================
// DASHBOARD CARD
// ================================================================

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF171717),
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.white),

            const Spacer(),

            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
