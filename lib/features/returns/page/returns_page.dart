import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/returns_header.dart';
import '../widgets/return_policy.dart';
import '../widgets/refund_process.dart';
import '../widgets/exchange_policy.dart';
import '../widgets/faq_returns.dart';
import '../widgets/return_request_button.dart';

class ReturnsPage extends StatelessWidget {
  const ReturnsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const ReturnsHeader(),

            const SizedBox(height: AppSpacing.xxxl),

            const ReturnPolicy(),

            const SizedBox(height: AppSpacing.xxxl),

            const RefundProcess(),

            const SizedBox(height: AppSpacing.xxxl),

            const ExchangePolicy(),

            const SizedBox(height: AppSpacing.xxxl),

            const FAQReturns(),
            const SizedBox(height: AppSpacing.xxl),

ReturnRequestButton(
  onPressed: () {
    // Navigate to Return Request Page
    // Firebase integration later
  },
),

const SizedBox(height: AppSpacing.xxxl),

          ],
        ),
      ),
    );
  }
}