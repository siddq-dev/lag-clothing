import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class FooterContact extends StatelessWidget {
  const FooterContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: AppTextStyles.heading4,
        ),

        const SizedBox(height: 16),

        const Row(
          children: [
            Icon(
              Icons.email_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            SizedBox(width: 8),
            Text(
              'info@lagclothing.com',
              style: AppTextStyles.bodyMedium,
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
              '+91 XXXXX XXXXX',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),

        const SizedBox(height: 12),

        const Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            SizedBox(width: 8),
            Text(
              'Tamil Nadu, India',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),

        const SizedBox(height: 20),

        Text(
          'Follow Us',
          style: AppTextStyles.heading4,
        ),

        const SizedBox(height: 12),

        const Row(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primary,
            ),
            SizedBox(width: 12),

            Icon(
              Icons.facebook_outlined,
              color: AppColors.primary,
            ),
            SizedBox(width: 12),

            Icon(
              Icons.chat_outlined,
              color: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}