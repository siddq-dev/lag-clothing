import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product_management_provider.dart';

class InventorySection extends StatelessWidget {
  const InventorySection({super.key});

@override
Widget build(BuildContext context) {
  final provider =
      context.read<ProductManagementProvider>();

    final stock = provider.totalStock;

    Color statusColor;
    String statusText;

    if (stock == 0) {
      statusColor = Colors.red;
      statusText = "Out of Stock";
    } else if (stock <= 10) {
      statusColor = Colors.orange;
      statusText = "Low Stock";
    } else {
      statusColor = Colors.green;
      statusText = "In Stock";
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Inventory",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1B1B),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Available Stock",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "$stock",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Calculated automatically from the product variants.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(.12),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.inventory_2,
                    color: statusColor,
                  ),

                  const SizedBox(width: 12),

                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
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
}