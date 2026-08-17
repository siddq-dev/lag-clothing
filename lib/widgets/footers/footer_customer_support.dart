import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../themes/app_text_style.dart';
import 'footer_section_title.dart';

class FooterCustomerSupport extends StatelessWidget {
  const FooterCustomerSupport({super.key});

  @override
  Widget build(BuildContext context) {
    final supportLinks = [
      ('FAQ', AppRouter.faq),
      ('Shipping Policy', AppRouter.shippingPolicy),
      ('Return & Refund Policy', AppRouter.returns),
      ('Exchange Policy', AppRouter.exchangePolicy),
      ('Size Guide', AppRouter.sizeGuide),
      ('Track Order', AppRouter.orderTracking),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FooterSectionTitle(title: 'Customer Support'),

        const SizedBox(height: 20),

        ...supportLinks.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                context.go(item.$2);
              },
              child: Text(item.$1, style: AppTextStyles.bodyMedium),
            ),
          ),
        ),
      ],
    );
  }
}
