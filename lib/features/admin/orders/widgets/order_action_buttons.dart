import 'package:flutter/material.dart';

class OrderActionButtons extends StatelessWidget {
  const OrderActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: FilledButton.icon(
            onPressed: () {},

            icon: const Icon(
              Icons.print,
            ),

            label: const Text(
              "Invoice",
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: FilledButton.icon(
            onPressed: () {},

            icon: const Icon(
              Icons.local_shipping,
            ),

            label: const Text(
              "Track",
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),

            onPressed: () {},

            icon: const Icon(
              Icons.cancel,
            ),

            label: const Text(
              "Cancel",
            ),
          ),
        ),

      ],
    );
  }
}