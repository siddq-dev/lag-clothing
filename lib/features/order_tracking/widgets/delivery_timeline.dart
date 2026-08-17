import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class DeliveryTimeline extends StatelessWidget {
  const DeliveryTimeline({super.key});

  Widget timelineTile({
    required String title,
    required String subtitle,
    required bool completed,
    required bool current,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: completed || current
                    ? AppColors.primary
                    : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: completed
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : current
                  ? const Icon(
                      Icons.local_shipping,
                      size: 10,
                      color: Colors.white,
                    )
                  : null,
            ),

            Container(width: 2, height: 55, color: Colors.grey.shade300),
          ],
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: current ? AppColors.primary : Colors.black,
                  ),
                ),

                const SizedBox(height: 5),

                Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Timeline",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            timelineTile(
              title: "Order Placed",
              subtitle: "20 July 2026 • 10:20 AM",
              completed: true,
              current: false,
            ),

            timelineTile(
              title: "Payment Confirmed",
              subtitle: "20 July 2026 • 10:22 AM",
              completed: true,
              current: false,
            ),

            timelineTile(
              title: "Packed",
              subtitle: "21 July 2026 • 03:45 PM",
              completed: true,
              current: false,
            ),

            timelineTile(
              title: "Shipped",
              subtitle: "22 July 2026 • 09:15 AM",
              completed: true,
              current: false,
            ),

            timelineTile(
              title: "Out For Delivery",
              subtitle: "25 July 2026 • 08:00 AM",
              completed: false,
              current: true,
            ),

            timelineTile(
              title: "Delivered",
              subtitle: "Waiting for delivery...",
              completed: false,
              current: false,
            ),
          ],
        ),
      ),
    );
  }
}
