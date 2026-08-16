import 'package:flutter/material.dart';

import '/core/constants/section_sizes.dart';

import 'hero_content.dart';
import 'hero_image.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SectionSizes.heroHeight,
      child: const Stack(
        fit: StackFit.expand,
        children: [
          // ============================================================
          // HERO SLIDESHOW
          // ============================================================
          HeroImage(),

          // ============================================================
          // DARK GRADIENT OVER IMAGE
          // ============================================================
          _HeroGradient(),

          // ============================================================
          // HERO CONTENT
          // ============================================================
          HeroContent(),
        ],
      ),
    );
  }
}

class _HeroGradient extends StatelessWidget {
  const _HeroGradient();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withValues(alpha: 0.78),
              Colors.black.withValues(alpha: 0.48),
              Colors.black.withValues(alpha: 0.12),
              Colors.transparent,
            ],
            stops: const [0.0, 0.38, 0.68, 1.0],
          ),
        ),
      ),
    );
  }
}
