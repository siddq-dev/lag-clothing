import 'package:flutter/material.dart';

class InventoryFilterBar extends StatelessWidget {
  const InventoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("All")),

        const SizedBox(width: 15),

        ElevatedButton(onPressed: () {}, child: const Text("In Stock")),

        const SizedBox(width: 15),

        ElevatedButton(onPressed: () {}, child: const Text("Low Stock")),

        const SizedBox(width: 15),

        ElevatedButton(onPressed: () {}, child: const Text("Out of Stock")),
      ],
    );
  }
}
