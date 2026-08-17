import 'package:flutter/material.dart';

class EmptyPayment extends StatelessWidget {
  const EmptyPayment({super.key, required this.onAddCard});

  final VoidCallback onAddCard;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Icon(
              Icons.credit_card_outlined,
              size: 90,
              color: Colors.grey.shade500,
            ),

            const SizedBox(height: 24),

            const Text(
              "No Payment Methods",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(
              "You haven't added any debit or credit cards yet.\nAdd a card for faster checkout.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, height: 1.6),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: onAddCard,
              icon: const Icon(Icons.add),
              label: const Text("Add Payment Method"),
            ),
          ],
        ),
      ),
    );
  }
}
