import 'package:flutter/material.dart';

import '../../../models/order_model.dart';

class OrderSummary extends StatelessWidget {
  final OrderModel order;

  const OrderSummary({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // ITEMS
            // =====================================================
            _summaryRow('Items', order.items.length.toString()),

            const SizedBox(height: 10),

            // =====================================================
            // SUBTOTAL
            // =====================================================
            _summaryRow('Subtotal', '₹${order.subtotal.toStringAsFixed(2)}'),

            const SizedBox(height: 10),

            // =====================================================
            // SHIPPING
            // =====================================================
            _summaryRow(
              'Shipping',
              order.shippingCharge <= 0
                  ? 'Free'
                  : '₹${order.shippingCharge.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 10),

            // =====================================================
            // TAX
            // =====================================================
            _summaryRow('Tax', '₹${order.tax.toStringAsFixed(2)}'),

            const SizedBox(height: 10),

            // =====================================================
            // DISCOUNT
            // =====================================================
            _summaryRow(
              'Discount',
              order.discount <= 0
                  ? '₹0.00'
                  : '-₹${order.discount.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 15),

            const Divider(color: Colors.white24),

            const SizedBox(height: 15),

            // =====================================================
            // TOTAL
            // =====================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
