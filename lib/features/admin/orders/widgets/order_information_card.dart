import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class OrderInformationCard extends StatelessWidget {
  const OrderInformationCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _infoRow("Order Number", order.orderNumber),

            _infoRow(
              "Tracking ID",
              order.trackingId.isEmpty ? "-" : order.trackingId,
            ),

            _infoRow("Order Status", order.orderStatus.name),

            _infoRow("Payment Status", order.paymentStatus.name),

            _infoRow("Payment Method", order.paymentMethod),

            _infoRow(
              "Created At",
              order.createdAt == null
                  ? "-"
                  : order.createdAt!.toDate().toString(),
            ),

            _infoRow(
              "Updated At",
              order.updatedAt == null
                  ? "-"
                  : order.updatedAt!.toDate().toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
