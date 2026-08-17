import 'package:flutter/material.dart';

class InventorySearchBar extends StatelessWidget {
  const InventorySearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: "Search Product",

        prefixIcon: const Icon(Icons.search),

        filled: true,

        fillColor: const Color(0xFF1A1A1A),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      onChanged: (_) {
        (context as Element).markNeedsBuild();
      },
    );
  }
}
