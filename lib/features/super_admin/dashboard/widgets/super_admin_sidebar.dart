import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routes/app_routes.dart';

class SuperAdminSidebar extends StatelessWidget {
  const SuperAdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.black,
      child: ListView(
        children: [

          const SizedBox(height: 40),

          const Center(
            child: Text(
              "LAG Clothing",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 50),

          _tile(
            context,
            Icons.dashboard,
            "Dashboard",
            AppRouter.superAdminDashboard,
          ),

          _tile(
            context,
            Icons.admin_panel_settings,
            "Admin Management",
            AppRouter.adminManagement,
          ),

          _tile(
            context,
            Icons.shopping_bag,
            "Manage Products",
            AppRouter.manageProducts,
          ),

          _tile(
            context,
            Icons.people,
            "Customers management",
            AppRouter.customerManagement,
          ),

          _tile(
            context,
            Icons.receipt_long,
            "Orders",
            AppRouter.adminOrderDetails,
          ),

          _tile(
            context,
            Icons.analytics,
            "Analytics",
            AppRouter.analytics,
          ),

           _tile(
            context,
            Icons.inventory_2,
            "Inventory",
            AppRouter.analytics,
          ),

          _tile(
            context,
            Icons.settings,
            "Website Settings",
            AppRouter.websiteSettings,
          ),

          _tile(
            context,
            Icons.logout,
            "Logout",
            AppRouter.login,
          ),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () => context.go(route),
    );
  }
}