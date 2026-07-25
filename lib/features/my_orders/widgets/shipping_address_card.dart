import 'package:flutter/material.dart';

class ShippingAddressCard extends StatelessWidget {
  const ShippingAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Address",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            Text("John Doe"),

            Text("+91 9876543210"),

            Text("Anna Nagar"),

            Text("Chennai"),

            Text("Tamil Nadu"),

            Text("600001"),
          ],
        ),
      ),
    );
  }
}
