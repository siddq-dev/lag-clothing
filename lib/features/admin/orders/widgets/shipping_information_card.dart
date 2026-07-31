import 'package:flutter/material.dart';

class ShippingInformationCard extends StatelessWidget {
  const ShippingInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "Shipping Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text("John Doe"),

            SizedBox(height: 8),

            Text(
              "No.12, Anna Street\nChennai\nTamil Nadu\n600001",
            ),

          ],
        ),
      ),
    );
  }
}