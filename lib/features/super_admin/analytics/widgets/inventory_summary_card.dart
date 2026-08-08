import 'package:flutter/material.dart';

import '/models/inventory_analytics_model.dart';

class InventorySummaryCard extends StatelessWidget {
  const InventorySummaryCard({super.key, required this.inventory});

  final InventoryAnalyticsModel inventory;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Inventory Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _inventoryTile(
                    title: "Products",
                    value: inventory.totalProducts.toString(),
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _inventoryTile(
                    title: "In Stock",
                    value: inventory.inStock.toString(),
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _inventoryTile(
                    title: "Low Stock",
                    value: inventory.lowStock.toString(),
                    icon: Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _inventoryTile(
                    title: "Out Of Stock",
                    value: inventory.outOfStock.toString(),
                    icon: Icons.cancel,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const Text("Inventory Value", style: TextStyle(fontSize: 16)),

                  const SizedBox(height: 8),

                  Text(
                    "₹${inventory.inventoryValue.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inventoryTile({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withValues(alpha: .08),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: .15),
            child: Icon(icon, color: color),
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(title),
        ],
      ),
    );
  }
}
