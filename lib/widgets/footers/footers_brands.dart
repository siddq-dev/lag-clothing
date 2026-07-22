import 'package:flutter/material.dart';

import '../../themes/app_text_style.dart';

class FooterBrand extends StatelessWidget {
  const FooterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Image.asset(
  'assets/images/logo/lag_logo.png',
  height: 60,
  fit: BoxFit.contain,
),

        const SizedBox(height: 16),

        Text(
          'Premium football jerseys inspired by clubs, countries, retro classics, and custom designs.',
          style: AppTextStyles.bodyMedium,
        ),

        const SizedBox(height: 24),

        Text(
          '© 2026 Lag Clothing. All rights reserved.',
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}