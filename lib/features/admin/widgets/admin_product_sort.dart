import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/admin_product_filter_provider.dart';

class AdminProductSort extends StatelessWidget {
  const AdminProductSort({super.key});

  static const List<String> sortOptions = [
    "Newest",
    "Oldest",
    "Name A-Z",
    "Name Z-A",
    "Price ↑",
    "Price ↓",
    "Stock ↑",
    "Stock ↓",
    "Rating",
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminProductFilterProvider>();

    return SizedBox(
      width: 220,
      child: DropdownButtonFormField<String>(
        initialValue: provider.sortBy,
        decoration: const InputDecoration(
          labelText: "Sort By",
          prefixIcon: Icon(Icons.sort),
          border: OutlineInputBorder(),
        ),
        items: sortOptions.map((option) {
          return DropdownMenuItem(value: option, child: Text(option));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            provider.updateSort(value);
          }
        },
      ),
    );
  }
}
