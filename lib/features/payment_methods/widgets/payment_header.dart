import 'package:flutter/material.dart';

import '../../../themes/app_text_style.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Payment Methods",
          style: AppTextStyles.heading2,
        ),

        const SizedBox(height: 10),

        const Text(
          "Manage your saved payment options.",
        ),

      ],
    );
  }
}