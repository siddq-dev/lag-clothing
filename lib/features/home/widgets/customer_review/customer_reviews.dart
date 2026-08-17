import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

import 'review_slider.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final isMobile = width < 600;

    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 60,
        vertical: isMobile ? 60 : 100,
      ),

      child: Column(
        children: [
          // ==================================================
          // TITLE
          // ==================================================
          const Text(
            'What Our Customers Say',
            style: AppTextStyles.sectionTitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // ==================================================
          // SUBTITLE
          // ==================================================
          const Text(
            'Trusted by football fans across India.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: isMobile ? 35 : 60),

          // ==================================================
          // REVIEWS
          // ==================================================
          const ReviewSlider(),

          SizedBox(height: isMobile ? 60 : 100),
        ],
      ),
    );
  }
}
