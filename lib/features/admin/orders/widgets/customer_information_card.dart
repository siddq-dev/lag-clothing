import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class CustomerInformationCard extends StatelessWidget {
  const CustomerInformationCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final customer = order.shippingAddress;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(customer.fullName),
              subtitle: Text(order.userId),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(customer.phone),
            ),

            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text("${customer.city}, ${customer.state}"),
              subtitle: Text(customer.country),
            ),
          ],
        ),
      ),
    );
  }
}
