import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';
import '../widgets/legal_bullet.dart';
import '../widgets/legal_header.dart';
import '../widgets/legal_section.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.about,
      child: Column(
        children: [
          const LegalHeader(
            title: "Careers",
            subtitle:
                "Join the LAG Clothing team and help us redefine sports fashion.",
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
                  heading: "Why Join LAG?",
                  body:
                      "We believe in creativity, innovation, teamwork, and providing opportunities for growth.",
                ),

                LegalSection(
                  heading: "Current Opportunities",
                  body:
                      "We regularly hire for Customer Support, Graphic Designers, Marketing Executives, Warehouse Operations, and Flutter Developers.",
                ),

                LegalSection(
                  heading: "Employee Benefits",
                  body: "",
                ),

                LegalBullet(
                  text: "Competitive salary packages.",
                ),

                LegalBullet(
                  text: "Flexible working environment.",
                ),

                LegalBullet(
                  text: "Career growth opportunities.",
                ),

                LegalBullet(
                  text: "Employee discounts on LAG products.",
                ),

                LegalSection(
                  heading: "Apply",
                  body:
                      "Send your resume to careers@lagclothing.com and we'll get back to you if your profile matches our requirements.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}