import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';
import '../widgets/legal_bullet.dart';
import '../widgets/legal_header.dart';
import '../widgets/legal_section.dart';

class ExchangePolicyPage extends StatelessWidget {
  const ExchangePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.exchangePolicy,
      child: Column(
        children: [
          const LegalHeader(
            title: "Exchange Policy",
            subtitle:
                "Our exchange policy ensures you receive the perfect fit and product.",
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                LegalSection(
                  heading: "Eligibility",
                  body:
                      "Products may be exchanged within 7 days of delivery if they are unused, unwashed, and returned with original tags.",
                ),

                LegalSection(
                  heading: "Exchange Process",
                  body:
                      "Submit an exchange request through My Orders. Our team will review your request and arrange pickup if approved.",
                ),

                LegalSection(
                  heading: "Important Notes",
                  body: "",
                ),

                LegalBullet(
                  text: "Only size exchanges are supported for eligible products.",
                ),

                LegalBullet(
                  text: "Customized jerseys cannot be exchanged.",
                ),

                LegalBullet(
                  text: "Damaged items should be reported within 48 hours.",
                ),

                LegalBullet(
                  text: "Exchange approval depends on stock availability.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}