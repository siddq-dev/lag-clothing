import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

import 'order_items_table.dart';

class CurrentOrderCard extends StatelessWidget {
  const CurrentOrderCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Order",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 40,
              runSpacing: 20,
              children: [
                _tile("Order Number", order.orderNumber),

                _tile(
                  "Ordered Date",
                  order.createdAt?.toDate().toString().split(" ").first ?? "-",
                ),

                _tile("Status", order.orderStatus.name),

                _tile("Payment", order.paymentMethod),

                _tile("Payment Status", order.paymentStatus.name),

                _tile("Tracking ID", order.trackingId),
              ],
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 20),

            const Text(
              "Shipping Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(order.shippingAddress.fullName),
            Text(order.shippingAddress.phone),
            Text(order.shippingAddress.addressLine1),
            Text(order.shippingAddress.city),

            const SizedBox(height: 25),

            const Divider(),

            const SizedBox(height: 25),

            OrderItemsTable(items: order.items),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Grand Total : ₹${order.total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(String title, String value) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 5),

          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
