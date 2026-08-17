import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';

class CancelOrderButton extends StatelessWidget {
  final String orderId;

  const CancelOrderButton({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<OrderProvider>().cancelOrder(orderId);
      },

      child: const Text("Cancel Order"),
    );
  }
}
