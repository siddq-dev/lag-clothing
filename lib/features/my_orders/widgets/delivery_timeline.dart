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

            TrackingStep(
              title: "Order Confirmed",

              subtitle: "Your order has been confirmed",

              completed: true,

              active: false,
            ),

            TrackingStep(
              title: "Packed",

              subtitle: "Your package is ready",

              completed: true,

              active: false,
            ),

            TrackingStep(
              title: "Shipped",

              subtitle: "Your order is on the way",

              completed: true,

              active: true,
            ),

            TrackingStep(
              title: "Out for Delivery",

              subtitle: "Delivery partner is nearby",

              completed: false,

              active: false,
            ),

            TrackingStep(
              title: "Delivered",

              subtitle: "Order delivered successfully",

              completed: false,

              active: false,
            ),
          ],
        ),
      ),
    );
  }
}
