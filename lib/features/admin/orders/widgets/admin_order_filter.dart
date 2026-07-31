import 'package:flutter/material.dart';

class AdminOrderFilter extends StatelessWidget {
  const AdminOrderFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Filters",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Order Status",
            ),
            items: const [
              DropdownMenuItem(
                value: "Pending",
                child: Text("Pending"),
              ),
              DropdownMenuItem(
                value: "Confirmed",
                child: Text("Confirmed"),
              ),
              DropdownMenuItem(
                value: "Packed",
                child: Text("Packed"),
              ),
              DropdownMenuItem(
                value: "Shipped",
                child: Text("Shipped"),
              ),
              DropdownMenuItem(
                value: "Delivered",
                child: Text("Delivered"),
              ),
              DropdownMenuItem(
                value: "Cancelled",
                child: Text("Cancelled"),
              ),
            ],
            onChanged: (_) {},
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Payment Method",
            ),
            items: const [
              DropdownMenuItem(
                value: "Paid",
                child: Text("Paid"),
              ),
              DropdownMenuItem(
                value: "COD",
                child: Text("Cash on Delivery"),
              ),
            ],
            onChanged: (_) {},
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Delivery Type",
            ),
            items: const [
              DropdownMenuItem(
                value: "Standard",
                child: Text("Standard"),
              ),
              DropdownMenuItem(
                value: "Express",
                child: Text("Express"),
              ),
            ],
            onChanged: (_) {},
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Apply Filters"),
            ),
          ),

        ],
      ),
    );
  }
}