import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
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
          height: 70,
        ),

        const SizedBox(height: 20),

        const Text(
          'Premium football jerseys\n inspired by clubs, countries, retro classics,\n and custom designs.',
          style: AppTextStyles.bodyMedium,
        ),

        const SizedBox(height: 24),

        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Chennai, Tamil Nadu, India',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        const Row(
          children: [
            Icon(
              Icons.phone_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            SizedBox(width: 8),
            Text(
              '+91 98765 43210',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),

        const SizedBox(height: 12),

        const Row(
          children: [
            Icon(
              Icons.email_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            SizedBox(width: 8),
            Text(
              'support@lagclothing.com',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.facebook),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_circle_outline),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.alternate_email),
            ),
          ],
        ),
      ],
    );
  }
}