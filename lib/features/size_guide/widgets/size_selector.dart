import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  final List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL"];

  int selected = 2;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: List.generate(sizes.length, (index) {
        final isSelected = selected == index;

        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              sizes[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
          selected: isSelected,
          selectedColor: AppColors.primary,
          backgroundColor: Colors.grey.shade200,
          onSelected: (_) {
            setState(() {
              selected = index;
            });
          },
        );
      }),
    );
  }
}
