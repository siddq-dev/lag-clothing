import 'package:flutter/material.dart';

class ReorderButton extends StatelessWidget {
  const ReorderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: () {}, child: const Text("Reorder")),
    );
  }
}
