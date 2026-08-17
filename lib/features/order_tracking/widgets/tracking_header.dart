import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

class TrackingHeader extends StatelessWidget {
  const TrackingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Track Your Order", style: AppTextStyles.heading2),

        const SizedBox(height: 12),

        const Text(
          "Stay updated with the latest status of your order from dispatch to delivery. "
          "You can monitor every step of your purchase in real time.",
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
