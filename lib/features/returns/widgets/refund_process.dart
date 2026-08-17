import 'package:flutter/material.dart';

class RefundProcess extends StatelessWidget {
  const RefundProcess({super.key});

  Widget step(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 18, child: Text(number)),

        const SizedBox(width: 20),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 6),

                Text(description, style: const TextStyle(height: 1.6)),
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Refund Process",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            step(
              "1",
              "Submit Return Request",
              "Go to My Orders and select the order you wish to return.",
            ),

            step(
              "2",
              "Verification",
              "Our support team will verify your request within 24 hours.",
            ),

            step(
              "3",
              "Pickup / Shipping",
              "Ship the product back or schedule a pickup where available.",
            ),

            step(
              "4",
              "Refund Issued",
              "Refund will be credited to your original payment method within 5-7 business days.",
            ),
          ],
        ),
      ),
    );
  }
}
