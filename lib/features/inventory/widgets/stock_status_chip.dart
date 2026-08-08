import 'package:flutter/material.dart';

class StockStatusChip extends StatelessWidget {
  const StockStatusChip({
    super.key,
    required this.stock,
    required this.reorderLevel,
  });

  final int stock;
  final int reorderLevel;

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    if (stock == 0) {
      color = Colors.red;
      text = "Out of Stock";
    } else if (stock <= reorderLevel) {
      color = Colors.orange;
      text = "Low Stock";
    } else {
      color = Colors.green;
      text = "In Stock";
    }

    return Chip(
      backgroundColor: color.withValues(alpha: .15),
      side: BorderSide(color: color),
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
