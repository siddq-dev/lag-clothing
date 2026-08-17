import 'package:flutter/material.dart';

class SuccessDetails extends StatelessWidget {
  const SuccessDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Thank you for shopping with LAG Clothing.\n\n"
      "Your order has been received and is now being processed.\n"
      "You can track the status of your order from your profile.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17, height: 1.6),
    );
  }
}
