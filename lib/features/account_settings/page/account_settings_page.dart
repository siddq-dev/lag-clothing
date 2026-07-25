import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/account_header.dart';
import '../widgets/profile_information_card.dart';
import '../widgets/notification_settings_card.dart';
import '../widgets/language_currency_card.dart';
import '../widgets/privacy_security_card.dart';
import '../widgets/danger_zone_card.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AccountHeader(),

            SizedBox(height: AppSpacing.xxxl),

            ProfileInformationCard(),

            SizedBox(height: AppSpacing.xxxl),

            NotificationSettingsCard(),

            SizedBox(height: AppSpacing.xxxl),

            LanguageCurrencyCard(),

            SizedBox(height: AppSpacing.xxxl),

            PrivacySecurityCard(),

            SizedBox(height: AppSpacing.xxxl),

            DangerZoneCard(),
          ],
        ),
      ),
    );
  }
}
