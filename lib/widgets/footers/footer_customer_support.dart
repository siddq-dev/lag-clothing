import 'package:flutter/material.dart';

import '../../themes/app_text_style.dart';
import 'footer_section_title.dart';

class FooterCustomerSupport extends StatelessWidget {
  const FooterCustomerSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        FooterSectionTitle(
          title: 'Customer Support',
        ),

        SizedBox(height: 20),

        Text('FAQ', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Shipping Policy', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Return & Refund Policy', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Exchange Policy', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Size Guide', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Track Order', style: AppTextStyles.bodyMedium),
      ],
    );
  }
}