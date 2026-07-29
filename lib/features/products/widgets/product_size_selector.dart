import 'package:flutter/material.dart';

class ProductSizeSelector extends StatelessWidget {
  const ProductSizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onChanged,
  });

  final List<String> sizes;
  final String? selectedSize;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    if (sizes.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Size",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: sizes.map((size) {
            final selected = size == selectedSize;

            return ChoiceChip(
              label: Text(size),
              selected: selected,
              onSelected: (_) => onChanged(size),
            );
          }).toList(),
        ),
      ],
    );
  }
}