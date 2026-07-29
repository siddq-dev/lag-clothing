import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/models/user_model.dart';
import '/providers/auth_provider.dart';
import '/routes/app_routes.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {

    final user =
        context.watch<AuthProvider>().currentUser;

    return Container(
      color: Colors.black,
      child: ListView(
        children: [

          const SizedBox(height: 40),

          const Center(
            child: Text(
              "LAG ADMIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 40),

          ListTile(
            leading: const Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            title: const Text(
              "Dashboard",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.go(
                AppRouter.adminDashboard,
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            title: const Text(
              "Products",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              context.go(
                AppRouter.manageProducts,
              );
            },
          ),

          if (user?.role ==
              UserRole.superAdmin)

            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
              ),
              title: const Text(
                "Admin Management",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                context.go(
                  AppRouter.adminManagement,
                );
              },
            ),

        ],
      ),
    );
  }
}