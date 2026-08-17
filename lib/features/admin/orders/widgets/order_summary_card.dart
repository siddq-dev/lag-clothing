import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _summaryRow("Subtotal", order.subtotal),

            const Divider(),

            _summaryRow("Shipping Charge", order.shippingCharge),

            const Divider(),

            _summaryRow("Discount", -order.discount, isDiscount: true),

            const Divider(),

            _summaryRow("Tax", order.tax),

            const Divider(thickness: 1.5),

            _summaryRow("Grand Total", order.total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    String title,
    double amount, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),

          Text(
            isDiscount
                ? "- ₹${amount.abs().toStringAsFixed(2)}"
                : "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isDiscount ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}
