import 'package:flutter/material.dart';

import '/providers/product_management_provider.dart';

class ProductStatistics extends StatelessWidget {
  const ProductStatistics({super.key, required this.provider});

  final ProductManagementProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _card(
            "Products",
            provider.totalProducts.toString(),
            Icons.inventory_2,
            Colors.blue,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Active",
            provider.activeProducts.toString(),
            Icons.check_circle,
            Colors.green,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Inactive",
            provider.inactiveProducts.toString(),
            Icons.cancel,
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _card(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, color: color, size: 40),

            const SizedBox(height: 15),

            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(title),
          ],
        ),
      ),
    );
  }
}
