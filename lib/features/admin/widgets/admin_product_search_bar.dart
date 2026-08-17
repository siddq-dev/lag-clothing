import 'package:flutter/material.dart';

class AdminProductSearchBar extends StatelessWidget {
  const AdminProductSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  final TextEditingController controller;

  final ValueChanged<String> onChanged;

  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search by Product, Brand or SKU",

          prefixIcon: const Icon(Icons.search),

          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,

          filled: true,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
