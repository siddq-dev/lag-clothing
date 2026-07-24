import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor = Colors.white,
    this.icon,
  });

  final String title;
  final String value;
  final Color valueColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 180,
            child: Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.grey.shade400,
              ),
            ),
          ),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (icon != null) ...[
                  Icon(
                    icon,
                    color: valueColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                ],

                Expanded(
                  child: Text(
                    value,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: valueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}