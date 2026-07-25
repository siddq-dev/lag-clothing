import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text(
          "Order #1002",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Placed on 25 July 2026"),
      ),
    );
  }
}
