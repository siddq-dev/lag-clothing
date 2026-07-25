import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/help_header.dart';
import '../widgets/faq_section.dart';
import '../widgets/contact_support_card.dart';
import '../widgets/social_support_links.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HelpHeader(),

            SizedBox(height: AppSpacing.xxxl),

            FAQSection(),

            SizedBox(height: AppSpacing.xxxl),

            ContactSupportCard(),

            SizedBox(height: AppSpacing.xxxl),

            SocialSupportLinks(),
          ],
        ),
      ),
    );
  }
}
