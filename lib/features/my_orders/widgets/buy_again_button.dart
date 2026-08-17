import 'package:flutter/material.dart';

import '../../../models/order_model.dart';

class BuyAgainButton extends StatelessWidget {
  final OrderModel order;

  const BuyAgainButton({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add items to cart later
      },

      child: const Text("Buy Again"),
    );
  }
}
