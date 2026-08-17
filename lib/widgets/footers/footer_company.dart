import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../themes/app_text_style.dart';
import 'footer_section_title.dart';

class FooterCompany extends StatelessWidget {
  const FooterCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final companyLinks = [
      ('Privacy Policy', AppRouter.privacyPolicy),
      ('Terms & Conditions', AppRouter.termsConditions),
      ('Cookie Policy', AppRouter.cookiePolicy),
      ('Careers', AppRouter.careers),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FooterSectionTitle(title: 'Company'),

        const SizedBox(height: 20),

        ...companyLinks.map(
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
