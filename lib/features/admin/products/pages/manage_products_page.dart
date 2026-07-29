import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../dashboard/widgets/admin_sidebar.dart';
import '../widgets/product_list_table.dart';
import '../../../../routes/app_routes.dart';

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Manage Products",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton.icon(
                        onPressed: () {
                          context.push(
                            AppRouter.addProduct,
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          "Add Product",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(20),
                        child:
                            ProductListTable(),
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