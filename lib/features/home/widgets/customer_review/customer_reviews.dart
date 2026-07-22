import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';

import 'review_slider.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({super.key});

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
            'What Our Customers Say',
            style: AppTextStyles.sectionTitle,
          ),

          SizedBox(height: 20),

          Text(
            'Trusted by football fans across India.',
            style: AppTextStyles.sectionSubtitle,
          ),

          SizedBox(height: 60),

          ReviewSlider(),
          
            const SizedBox(height: 100),

        ],
      ),
    );
  }
}