import 'package:flutter/material.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        status.toUpperCase(),

        style: const TextStyle(color: Colors.white),
      ),

      backgroundColor: Colors.grey.shade800,
    );
  }
}
