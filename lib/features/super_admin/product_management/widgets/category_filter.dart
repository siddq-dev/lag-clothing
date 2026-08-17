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
    'All',
    'Football Jerseys',
    'Cricket Jerseys',
    'Basketball Jerseys',
    'Volleyball Jerseys',
    'Esports Jerseys',
    'Training Wear',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return SizedBox(
      width: isMobile ? double.infinity : 280,
      child: DropdownButtonFormField<String>(
        initialValue: value.isEmpty ? 'All' : value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Category',
          prefixIcon: const Icon(Icons.category_outlined),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        items: categories.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
