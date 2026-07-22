import 'package:flutter/material.dart';
import 'package:lag_clothing/core/constants/section_sizes.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SectionSizes.categoriesHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Categories Section',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}