import 'package:flutter/material.dart';

class TrackingStep extends StatelessWidget {
  const TrackingStep({super.key, required this.title, required this.completed});

  final String title;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        completed ? Icons.check_circle : Icons.radio_button_unchecked,
      ),
      title: Text(title),
    );
  }
}
