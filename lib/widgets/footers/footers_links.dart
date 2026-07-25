import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../themes/app_text_style.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final links = [
      ('Home', AppRouter.home),
      ('Shop', AppRouter.shop),
      ('About Us', AppRouter.about),
      ('Contact Us', AppRouter.contact),
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
            child: InkWell(
              onTap: () => context.go(link.$2),
              borderRadius: BorderRadius.circular(4),
              child: Text(
                link.$1,
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}