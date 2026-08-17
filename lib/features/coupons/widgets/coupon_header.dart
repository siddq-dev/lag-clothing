import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

class CouponHeader extends StatelessWidget {
  const CouponHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Coupons & Offers", style: AppTextStyles.heading2),

        const SizedBox(height: 12),

        const Text(
          "Save more on every purchase by applying available coupons during checkout.",
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
