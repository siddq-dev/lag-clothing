import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class CallToAction extends StatelessWidget {
  const CallToAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 100,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [

          Text(
            'Ready to Wear Your Passion?',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          const SizedBox(
            width: 650,
            child: Text(
              'Discover premium football jerseys inspired by clubs, countries, and football culture. Join the LAG Clothing family and wear your passion with pride.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              // GoRouter later
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Explore Collection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}