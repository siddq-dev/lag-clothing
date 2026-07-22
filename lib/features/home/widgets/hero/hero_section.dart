import 'package:flutter/material.dart';
import 'package:lag_clothing/core/constants/section_sizes.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
  height: SectionSizes.heroHeight,
  width: double.infinity,
  alignment: Alignment.center,
  child: const Text(
    'Hero Section',
    style: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
  ),
);
}
}