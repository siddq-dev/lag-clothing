import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import 'previous_order_tile.dart';

class PreviousOrdersSection extends StatelessWidget {
  const PreviousOrdersSection({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(child: Text("No Previous Orders")),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Previous Orders",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            ...orders.map(
              (order) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: PreviousOrderTile(order: order),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
