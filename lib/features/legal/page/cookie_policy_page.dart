import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';
import '../widgets/legal_bullet.dart';
import '../widgets/legal_header.dart';
import '../widgets/legal_section.dart';

class CookiePolicyPage extends StatelessWidget {
  const CookiePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.cookiePolicy,
      child: Column(
        children: [
          const LegalHeader(
            title: "Cookie Policy",
            subtitle:
                "This Cookie Policy explains how LAG Clothing uses cookies to improve your browsing experience.",
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
                  heading: "What Are Cookies?",
                  body:
                      "Cookies are small text files stored on your device that help websites remember your preferences and improve user experience.",
                ),

                LegalSection(
                  heading: "How We Use Cookies",
                  body:
                      "Cookies help us keep you logged in, remember shopping cart items, analyze website traffic, and improve performance.",
                ),

                LegalSection(
                  heading: "Types of Cookies",
                  body: "",
                ),

                LegalBullet(
                  text: "Essential Cookies",
                ),

                LegalBullet(
                  text: "Performance Cookies",
                ),

                LegalBullet(
                  text: "Analytics Cookies",
                ),

                LegalBullet(
                  text: "Marketing Cookies",
                ),

                LegalSection(
                  heading: "Managing Cookies",
                  body:
                      "You can disable or delete cookies from your browser settings. However, some website features may not function properly.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}