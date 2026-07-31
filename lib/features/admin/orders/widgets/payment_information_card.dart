import 'package:flutter/material.dart';

class PaymentInformationCard extends StatelessWidget {
  const PaymentInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "Payment Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            ListTile(
              leading: Icon(Icons.payments),
              title: Text("Paid"),
              subtitle: Text("Razorpay"),
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text("Transaction ID"),
              subtitle: Text("TXN123456789"),
            ),

          ],
        ),
      ),
    );
  }
}