import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

import 'feature_card.dart';
import 'feature_data.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Column(
        children: [
          const Text(
            'Why Choose LAG Clothing?',
            style: AppTextStyles.sectionTitle,
          ),

          const SizedBox(height: 16),

          const Text(
            'We provide premium-quality jerseys designed for comfort, performance, and style.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return FeatureCard(
                feature: features[index],
              );
            },
          ),
        ],
      ),
    );
  }
}