import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '₹${price.toStringAsFixed(0)}',
      style: AppTextStyles.cardTitle.copyWith(
        color: AppColors.primary,
      ),
    );
  }
}