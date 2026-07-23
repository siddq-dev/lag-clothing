import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class Values extends StatelessWidget {
  const Values({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 100,
      ),
      color: AppColors.surface,
      child: Column(
        children: [

          Text(
            'OUR VALUES',
            style: AppTextStyles.sectionTitle.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 20),

          const SizedBox(
            width: 700,
            child: Text(
              'These values guide every decision we make and every jersey we create.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge,
            ),
          ),

          const SizedBox(height: 70),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: 1.2,
            children: const [

              ValueCard(
                icon: Icons.workspace_premium_outlined,
                title: 'Premium Quality',
                description:
                    'Every jersey is made using quality materials for comfort, durability, and performance.',
              ),

              ValueCard(
                icon: Icons.favorite_outline,
                title: 'Passion for Football',
                description:
                    'Football is at the heart of everything we create and every design we deliver.',
              ),

              ValueCard(
                icon: Icons.people_outline,
                title: 'Customer First',
                description:
                    'Our customers inspire us to deliver the best shopping experience possible.',
              ),

              ValueCard(
                icon: Icons.palette_outlined,
                title: 'Authentic Designs',
                description:
                    'Unique collections inspired by football clubs, nations, and unforgettable moments.',
              ),

              ValueCard(
                icon: Icons.rocket_launch_outlined,
                title: 'Innovation',
                description:
                    'We continuously improve our products, designs, and customer experience.',
              ),

              ValueCard(
                icon: Icons.verified_user_outlined,
                title: 'Trust & Transparency',
                description:
                    'Honest pricing, secure shopping, and reliable service build long-term trust.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ValueCard extends StatelessWidget {
  const ValueCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            size: 42,
            color: AppColors.primary,
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: AppTextStyles.heading3,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}