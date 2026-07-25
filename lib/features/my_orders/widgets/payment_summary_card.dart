import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  const PaymentSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Text("Subtotal : ₹2,499"),

            Text("Shipping : ₹99"),

            Text("Discount : ₹100"),

            Divider(),

            Text(
              "Grand Total : ₹2,498",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
