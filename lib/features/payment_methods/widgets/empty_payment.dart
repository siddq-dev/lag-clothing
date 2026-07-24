import 'package:flutter/material.dart';

class EmptyPayment extends StatelessWidget {
  const EmptyPayment({super.key});

@override
Widget build(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [

            Icon(
              Icons.credit_card_off,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Text(
              "No Payment Methods Found",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Text(
              "Save your debit or credit card\nfor faster checkout.",
              textAlign: TextAlign.center,
            ),

          ],
        ),
      );
  }
}