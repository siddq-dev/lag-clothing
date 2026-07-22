import 'package:flutter/material.dart';

import '../../themes/app_text_style.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.club,
    required this.title,
  });

  final String club;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          club,
          style: AppTextStyles.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: AppTextStyles.cardTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}