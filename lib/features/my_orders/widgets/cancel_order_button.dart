import 'package:flutter/material.dart';

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text("Cancel Order"),
      ),
    );
  }
}
