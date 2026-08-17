import 'package:flutter/material.dart';

import '/providers/inventory_provider.dart';

class InventorySummaryCards extends StatelessWidget {
  const InventorySummaryCards({super.key, required this.provider});

  final InventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _card(
            "Products",
            provider.totalProducts.toString(),
            Colors.blue,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card("In Stock", provider.inStock.toString(), Colors.green),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Low Stock",
            provider.lowStock.toString(),
            Colors.orange,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Out of Stock",
            provider.outOfStock.toString(),
            Colors.red,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Inventory Value",
            "₹${provider.inventoryValue.toStringAsFixed(0)}",
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _card(String title, String value, Color color) {
    return Card(
      color: const Color(0xFF1A1A1A),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(title, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
