import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

import 'feature_card.dart';
import 'feature_data.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;

    final double horizontalPadding = isMobile
        ? 16
        : isTablet
        ? 30
        : 60;

    final double verticalPadding = isMobile ? 50 : 80;

    final int columns = isMobile
        ? 2
        : isTablet
        ? 2
        : 4;

    final double spacing = isMobile ? 10 : 24;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        children: [
          // ============================================================
          // TITLE
          // ============================================================
          Text(
            'Why Choose LAG Clothing?',
            style: AppTextStyles.sectionTitle.copyWith(
              fontSize: isMobile ? 26 : null,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // ============================================================
          // SUBTITLE
          // ============================================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
            child: Text(
              'We provide premium-quality jerseys designed for comfort, performance, and style.',
              style: AppTextStyles.sectionSubtitle.copyWith(
                fontSize: isMobile ? 14 : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: isMobile ? 30 : 50),

          // ============================================================
          // FEATURES
          // ============================================================
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,

              // Give mobile cards enough vertical room.
              childAspectRatio: isMobile
                  ? 0.82
                  : isTablet
                  ? 1.0
                  : 1.1,
            ),
            itemBuilder: (context, index) {
              return FeatureCard(feature: features[index]);
            },
          ),
        ],
      ),
    );
  }
}
