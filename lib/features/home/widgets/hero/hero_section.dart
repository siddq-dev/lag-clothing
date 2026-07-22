import 'package:flutter/material.dart';

import '/core/constants/section_sizes.dart';

import 'hero_content.dart';
import 'hero_image.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SectionSizes.heroHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 40,
      ),
      child: Row(
        children: const [
          HeroContent(),

          SizedBox(width: 60),

          HeroImage(),
        ],
      ),
    );
  }
}