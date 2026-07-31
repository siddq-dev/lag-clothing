import 'package:flutter/material.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: const [

            Text(
              "Order Timeline",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              title: Text("Order Placed"),
              subtitle: Text(
                "31 Jul 2026 • 09:30 AM",
              ),
            ),

            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.inventory,
                  color: Colors.white,
                ),
              ),
              title: Text("Packed"),
              subtitle: Text(
                "31 Jul 2026 • 02:00 PM",
              ),
            ),

            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                ),
              ),
              title: Text("Shipped"),
              subtitle: Text(
                "Waiting...",
              ),
            ),

            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              title: Text("Delivered"),
              subtitle: Text(
                "Pending",
              ),
            ),

          ],
        ),
      ),
    );
  }
}