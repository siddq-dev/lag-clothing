import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../dashboard/widgets/super_admin_sidebar.dart';
import '../widgets/admin_list_table.dart';

class AdminManagementPage extends StatelessWidget {
  const AdminManagementPage({super.key});

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
                  Row(
                    children: [
                      const Text(
                        "Admin Management",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton.icon(
                        onPressed: () {
                          context.push(AppRouter.addAdmin);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add Admin"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: AdminListTable(),
                      ),
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
