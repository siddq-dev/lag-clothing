import 'package:flutter/material.dart';

import 'tracking_step.dart';

class DeliveryTimeline extends StatelessWidget {
  const DeliveryTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Track Your Order",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            TrackingStep(title: "Order Confirmed", completed: true),

            TrackingStep(title: "Packed", completed: true),

            TrackingStep(title: "Shipped", completed: true),

            TrackingStep(title: "Out for Delivery", completed: false),

            TrackingStep(title: "Delivered", completed: false),
          ],
        ),
      ),
    );
  }
}
