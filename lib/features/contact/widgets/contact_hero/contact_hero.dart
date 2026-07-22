import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

class ContactHero extends StatelessWidget {
  const ContactHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 100,
      ),
      child: const Column(
        children: [

          Text(
            'Contact Us',
            style: AppTextStyles.heroTitle,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24),

          SizedBox(
            width: 700,
            child: Text(
              "We're always happy to hear from you. Whether you have a question about our products, your order, or simply want to share your feedback, our team is here to help.",
              style: AppTextStyles.sectionSubtitle,
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}