import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Quantity",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        IconButton(
          onPressed: quantity > 1
              ? () => onChanged(quantity - 1)
              : null,
          icon: const Icon(Icons.remove),
        ),

        Text(
          quantity.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        IconButton(
          onPressed: () => onChanged(quantity + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}