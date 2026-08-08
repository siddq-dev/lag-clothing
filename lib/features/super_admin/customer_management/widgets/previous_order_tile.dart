import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';

class PreviousOrderTile extends StatelessWidget {
  const PreviousOrderTile({super.key, required this.order});

  final OrderModel order;

  Color _statusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return Colors.orange;

      case OrderStatus.confirmed:
        return Colors.blue;

      case OrderStatus.packed:
        return Colors.deepPurple;

      case OrderStatus.shipped:
        return Colors.indigo;

      case OrderStatus.outForDelivery:
        return Colors.teal;

      case OrderStatus.delivered:
        return Colors.green;

      case OrderStatus.cancelled:
        return Colors.red;

      case OrderStatus.returned:
        return Colors.brown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                order.orderNumber,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: Text(
                order.createdAt?.toDate().toString().split(" ").first ?? "-",
              ),
            ),

            Expanded(
              child: Chip(
                backgroundColor: _statusColor(
                  order.orderStatus,
                ).withValues(alpha: .15),
                label: Text(
                  order.orderStatus.name.toUpperCase(),
                  style: TextStyle(
                    color: _statusColor(order.orderStatus),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Text(
                "₹${order.total.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(child: Text(order.trackingId)),

            ElevatedButton(
              onPressed: () {
                _showOrderDialog(context);
              },
              child: const Text("View"),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(order.orderNumber),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Status : ${order.orderStatus.name}"),
                  const SizedBox(height: 10),

                  Text("Payment : ${order.paymentMethod}"),
                  const SizedBox(height: 10),

                  Text("Payment Status : ${order.paymentStatus.name}"),
                  const SizedBox(height: 10),

                  Text("Tracking ID : ${order.trackingId}"),
                  const Divider(height: 30),

                  const Text(
                    "Items",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...order.items.map(
                    (item) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.productName),
                      subtitle: Text("Qty : ${item.quantity}"),
                      trailing: Text("₹${item.total.toStringAsFixed(2)}"),
                    ),
                  ),

                  const Divider(height: 30),

                  Text("Subtotal : ₹${order.subtotal}"),
                  Text("Shipping : ₹${order.shippingCharge}"),
                  Text("Discount : ₹${order.discount}"),
                  Text("Tax : ₹${order.tax}"),

                  const SizedBox(height: 15),

                  Text(
                    "Grand Total : ₹${order.total}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  if (order.adminNotes.isNotEmpty) ...[
                    const Divider(height: 30),

                    const Text(
                      "Admin Notes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 8),

                    Text(order.adminNotes),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
