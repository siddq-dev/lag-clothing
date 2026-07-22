import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key});

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
            'Visit Our Store',
            style: AppTextStyles.sectionTitle,
          ),

          const SizedBox(height: 16),

          const Text(
            'We are always happy to welcome you.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          Container(
            width: 900,
            height: 400,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.location_on,
                    size: 80,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Google Maps Placeholder',
                    style: AppTextStyles.heading3,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'LAG Clothing\nChennai, Tamil Nadu',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}