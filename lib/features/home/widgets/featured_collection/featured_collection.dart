import 'package:flutter/material.dart';
import 'package:lag_clothing/core/constants/section_sizes.dart';

class FeaturedCollection extends StatelessWidget {
  const FeaturedCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SectionSizes.featuredCollectionHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Featured Collection',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}