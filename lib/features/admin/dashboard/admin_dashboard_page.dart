import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';

import 'widgets/admin_sidebar.dart';

import 'widgets/admin_appbar.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebsiteLayout(
      currentRoute: "",
      child: Row(
        children: [
          SizedBox(width: 260, child: AdminSidebar()),

          Expanded(
            child: Column(
              children: [
                AdminAppBar(),

                Expanded(
                  child: Center(
                    child: Text(
                      "Admin Dashboard",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
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
