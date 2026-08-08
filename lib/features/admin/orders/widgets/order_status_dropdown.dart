import 'package:flutter/material.dart';

class OrderStatusDropdown extends StatefulWidget {
  const OrderStatusDropdown({super.key});

  @override
  State<OrderStatusDropdown> createState() => _OrderStatusDropdownState();
}

class _OrderStatusDropdownState extends State<OrderStatusDropdown> {
  String status = "Pending";

  final List<String> statuses = [
    "Pending",
    "Confirmed",
    "Packed",
    "Shipped",
    "Delivered",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: status,

      decoration: const InputDecoration(
        labelText: "Order Status",
        border: OutlineInputBorder(),
      ),

      items: statuses
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),

      onChanged: (value) {
        if (value == null) return;

        setState(() {
          status = value;
        });
      },
    );
  }
}
