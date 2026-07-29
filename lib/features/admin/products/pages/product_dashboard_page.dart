import 'package:flutter/material.dart';

import '../../../../layout/website_layout.dart';
import '../../../../routes/app_routes.dart';

import '../widgets/product_list_table.dart';


class ProductDashboardPage extends StatelessWidget {
  const ProductDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.adminProducts,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Expanded(
                  child: Text(
                    "Product Management",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.addProduct,
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Product"),
                ),

              ],
            ),

            const SizedBox(height: 40),

            const Expanded(
              child: ProductListTable(),
            ),

          ],
        ),
      ),
    );
  }
}