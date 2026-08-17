import 'package:flutter/material.dart';

class SuccessHeader extends StatelessWidget {
  const SuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.check_circle, color: Colors.green, size: 90),

        SizedBox(height: 20),

        Text(
          "Order Placed Successfully!",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
