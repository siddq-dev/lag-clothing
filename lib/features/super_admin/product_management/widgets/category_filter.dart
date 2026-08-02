import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;

  final ValueChanged<String?> onChanged;

  static const List<String> categories = [
     "All",
    "Football Jerseys",
    "Cricket Jerseys",
    "Basketball Jerseys",
    "Volleyball Jerseys",
    "Esports Jerseys",
    "Training Wear",
    "Accessories",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: const InputDecoration(
        labelText: "Category",
        border: OutlineInputBorder(),
      ),
      items: categories
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}