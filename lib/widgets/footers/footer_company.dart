import 'package:flutter/material.dart';

import '../../themes/app_text_style.dart';
import 'footer_section_title.dart';

class FooterCompany extends StatelessWidget {
  const FooterCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        FooterSectionTitle(
          title: 'Company',
        ),

        SizedBox(height: 20),

        Text('Privacy Policy', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Terms & Conditions', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Cookie Policy', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),

        Text('Careers', style: AppTextStyles.bodyMedium),
      ],
    );
  }
}