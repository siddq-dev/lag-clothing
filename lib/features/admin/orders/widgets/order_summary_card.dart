import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            _row(
              "Subtotal",
              "₹3200",
            ),

            const SizedBox(height: 12),

            _row(
              "Shipping",
              "₹150",
            ),

            const SizedBox(height: 12),

            _row(
              "Discount",
              "-₹300",
            ),

            const Divider(),

            _row(
              "Grand Total",
              "₹3050",
              bold: true,
            ),

          ],
        ),
      ),
    );
  }

  Widget _row(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: TextStyle(
            fontWeight:
                bold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            fontWeight:
                bold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),

      ],
    );
  }
}