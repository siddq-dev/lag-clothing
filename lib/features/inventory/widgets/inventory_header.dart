import 'package:flutter/material.dart';

class InventoryHeader extends StatelessWidget {
  const InventoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.inventory_2, size: 34, color: Colors.white),

        const SizedBox(width: 15),

        const Text(
          "Inventory Management",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        ElevatedButton.icon(
          onPressed: () {},

          icon: const Icon(Icons.add),

          label: const Text("Add Stock"),
        ),
      ],
    );
  }
}
