import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class PaymentInformationCard extends StatelessWidget {
  const PaymentInformationCard({super.key, required this.order});

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
              "Payment Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _row("Payment Method", order.paymentMethod),

            const Divider(),

            _row("Payment Status", order.paymentStatus.name.toUpperCase()),

            const Divider(),

            _row("Subtotal", "₹${order.subtotal.toStringAsFixed(2)}"),

            const Divider(),

            _row(
              "Shipping Charge",
              "₹${order.shippingCharge.toStringAsFixed(2)}",
            ),

            const Divider(),

            _row("Discount", "- ₹${order.discount.toStringAsFixed(2)}"),

            const Divider(),

            _row("Tax", "₹${order.tax.toStringAsFixed(2)}"),

            const Divider(),

            _row(
              "Grand Total",
              "₹${order.total.toStringAsFixed(2)}",
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
