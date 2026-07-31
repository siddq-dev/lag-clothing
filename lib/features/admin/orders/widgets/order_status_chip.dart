import 'package:flutter/material.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({
    super.key,
    required this.status,
  });

  final String status;

  Color get color {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;

      case "confirmed":
        return Colors.blue;

      case "packed":
        return Colors.deepPurple;

      case "shipped":
        return Colors.indigo;

      case "delivered":
        return Colors.green;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(.15),
      label: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}