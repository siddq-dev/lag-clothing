import 'package:flutter/material.dart';

import '/models/order_model.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({super.key, required this.status});

  String _label(String value) {
    switch (value) {
      case 'placed':
        return 'ORDER PLACED';

      case 'confirmed':
        return 'CONFIRMED';

      case 'packed':
        return 'PACKED';

      case 'shipped':
        return 'SHIPPED';

      case 'outForDelivery':
        return 'OUT FOR DELIVERY';

      case 'delivered':
        return 'DELIVERED';

      case 'cancelled':
        return 'CANCELLED';

      case 'refundRequested':
        return 'REFUND REQUESTED';

      case 'exchangeRequested':
        return 'EXCHANGE REQUESTED';

      case 'returned':
        return 'RETURNED';

      default:
        return value.toUpperCase();
    }
  }

  Color _color(String value) {
    switch (value) {
      case 'confirmed':
        return Colors.blue;

      case 'packed':
        return Colors.indigo;

      case 'shipped':
      case 'outForDelivery':
        return Colors.orange;

      case 'delivered':
        return Colors.green;

      case 'cancelled':
        return Colors.red;

      case 'refundRequested':
        return Colors.purple;

      case 'exchangeRequested':
        return Colors.teal;

      case 'returned':
        return Colors.deepOrange;

      case 'placed':
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(status);

    return Chip(
      label: Text(
        _label(status),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.25),
      side: BorderSide(color: color.withValues(alpha: 0.6)),
    );
  }
}
