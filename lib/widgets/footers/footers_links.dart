import 'package:flutter/material.dart';

import '../../themes/app_text_style.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    const links = [
      'Home',
      'Shop',
      'About Us',
      'Contact Us',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: AppTextStyles.heading4,
        ),

        const SizedBox(height: 16),

        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              link,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}