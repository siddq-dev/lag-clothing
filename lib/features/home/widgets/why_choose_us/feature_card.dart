import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

import 'feature_data.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key, required this.feature});

  final FeatureData feature;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;

    final double padding = isMobile
        ? 14
        : isTablet
        ? 20
        : 30;

    final double iconSize = isMobile
        ? 34
        : isTablet
        ? 40
        : 48;

    final double iconSpacing = isMobile ? 12 : 24;

    final double titleSpacing = isMobile ? 8 : 12;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ============================================================
          // ICON
          // ============================================================
          Icon(feature.icon, size: iconSize, color: AppColors.primary),

          SizedBox(height: iconSpacing),

          // ============================================================
          // TITLE
          // ============================================================
          Text(
            feature.title,
            style: AppTextStyles.heading3.copyWith(
              fontSize: isMobile ? 15 : null,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: titleSpacing),

          // ============================================================
          // DESCRIPTION
          // ============================================================
          Flexible(
            child: Text(
              feature.description,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: isMobile ? 12 : null,
              ),
              textAlign: TextAlign.center,
              maxLines: isMobile ? 4 : null,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
