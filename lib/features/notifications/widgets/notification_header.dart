import 'package:flutter/material.dart';

import '../../../themes/app_text_style.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Notifications",
          style: AppTextStyles.heading2,
        ),

        const SizedBox(height: 10),

        const Text(
          "Stay updated with your orders, offers and new arrivals.",
        ),

      ],
    );
  }
}