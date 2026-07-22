import 'package:flutter/material.dart';
import 'package:lag_clothing/core/constants/section_sizes.dart';

class NewsletterSection extends StatelessWidget {
  const NewsletterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SectionSizes.newsletterHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Newsletter Section',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}