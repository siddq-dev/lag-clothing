import 'package:flutter/material.dart';

class ProductColorSelector extends StatelessWidget {
  const ProductColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onChanged,
  });

  final List<String> colors;
  final String? selectedColor;
  final ValueChanged<String> onChanged;

  Color _parseColor(String value) {
    switch (value.toLowerCase()) {
      case "black":
        return Colors.black;

      case "white":
        return Colors.white;

      case "red":
        return Colors.red;

      case "blue":
        return Colors.blue;

      case "green":
        return Colors.green;

      case "yellow":
        return Colors.yellow;

      case "orange":
        return Colors.orange;

      case "grey":
        return Colors.grey;

      case "pink":
        return Colors.pink;

      case "purple":
        return Colors.purple;

      case "brown":
        return Colors.brown;

      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Color",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          children: colors.map((color) {
            final selected = color == selectedColor;

            return GestureDetector(
              onTap: () => onChanged(color),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: _parseColor(color),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: selected ? 3 : 1,
                    color: selected
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}