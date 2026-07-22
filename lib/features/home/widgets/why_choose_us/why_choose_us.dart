import 'package:flutter/material.dart';
import 'package:lag_clothing/core/constants/section_sizes.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SectionSizes.whyChooseUsHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Why Choose Us',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}