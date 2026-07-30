import 'package:flutter/material.dart';

import '../widgets/super_admin_sidebar.dart';

class SuperAdminDashboardPage extends StatelessWidget {
  const SuperAdminDashboardPage({super.key});

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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Super Admin Dashboard",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: const [

                      _DashboardCard(
                        title: "Total Admins",
                        value: "0",
                        icon: Icons.admin_panel_settings,
                      ),

                      _DashboardCard(
                        title: "Products",
                        value: "0",
                        icon: Icons.shopping_bag,
                      ),

                      _DashboardCard(
                        title: "Customers",
                        value: "0",
                        icon: Icons.people,
                      ),

                      _DashboardCard(
                        title: "Orders",
                        value: "0",
                        icon: Icons.receipt_long,
                      ),

                    ],
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Icon(
                icon,
                size: 35,
              ),

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