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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SuperAdminSidebar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==================================================
                  // HEADER
                  // ==================================================
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Super Admin Dashboard",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        tooltip: "Refresh",
                        onPressed: _refresh,
                        icon: const Icon(Icons.refresh, size: 28),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // STATISTICS
                  // ==================================================
                  Expanded(
                    child: FutureBuilder<Map<String, int>>(
                      future: _statisticsFuture,
                      builder: (context, snapshot) {
                        // --------------------------------------------
                        // LOADING
                        // --------------------------------------------

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // --------------------------------------------
                        // ERROR
                        // --------------------------------------------

                        if (snapshot.hasError) {
                          return Center(
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
                                  "Unable to load dashboard data.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  snapshot.error.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.grey),
                                ),

                                const SizedBox(height: 20),

                                FilledButton.icon(
                                  onPressed: _refresh,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text("Retry"),
                                ),
                              ],
                            ),
                          );
                        }

                        // --------------------------------------------
                        // NO DATA
                        // --------------------------------------------

                        final data = snapshot.data;

                        if (data == null) {
                          return const Center(
                            child: Text("No dashboard data available."),
                          );
                        }

                        // --------------------------------------------
                        // VALUES
                        // --------------------------------------------

                        final totalAdmins = data['admins'] ?? 0;

                        final totalProducts = data['products'] ?? 0;

                        final totalCustomers = data['customers'] ?? 0;

                        final totalOrders = data['orders'] ?? 0;

                        // --------------------------------------------
                        // CARDS
                        // --------------------------------------------

                        return SingleChildScrollView(
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              _DashboardCard(
                                title: "Total Admins",
                                value: totalAdmins.toString(),
                                icon: Icons.admin_panel_settings,
                              ),

                              _DashboardCard(
                                title: "Products",
                                value: totalProducts.toString(),
                                icon: Icons.shopping_bag,
                              ),

                              _DashboardCard(
                                title: "Customers",
                                value: totalCustomers.toString(),
                                icon: Icons.people,
                              ),

                              _DashboardCard(
                                title: "Orders",
                                value: totalOrders.toString(),
                                icon: Icons.receipt_long,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    return SizedBox(
      width: 240,
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 35),

              const Spacer(),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
