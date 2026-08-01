import 'package:flutter/material.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.analytics,
          size: 36,
        ),

        const SizedBox(width: 15),

        const Text(
          "Website Analytics",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        FilledButton.icon(
          onPressed: () {},

          icon: const Icon(
            Icons.download,
          ),

          label: const Text(
            "Export Report",
          ),
        ),
      ],
    );
  }
}