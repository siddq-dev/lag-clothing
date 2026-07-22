import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';
import '../../../../core/constants/section_sizes.dart';

import 'category_card.dart';
import '../../../../models/category_models.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Column(
        children: [
          const Text(
            'Shop By Category',
            style: AppTextStyles.sectionTitle,
          ),

          const SizedBox(height: 16),

          const Text(
            'Find the perfect jersey for every fan.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];

              return SizedBox(
                height: SectionSizes.categoryCardHeight,
                child: CategoryCard(
                  category: category,
                  onTap: () {
                    // TODO:
                    // Navigate to Shop Page
                    // (We'll connect this after GoRouter setup)
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}