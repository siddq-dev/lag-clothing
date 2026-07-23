import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class ShopSidebar extends StatelessWidget {
  const ShopSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'FILTERS',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 24),

          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text('Category'),
            children: [

              ListTile(
                dense: true,
                title: const Text('Club Jerseys'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('National Jerseys'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('Retro Jerseys'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('Training Kits'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('Goalkeeper Jerseys'),
                onTap: () {},
              ),
            ],
          ),

          const Divider(),

          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text('Size'),
            children: [

              ListTile(
                dense: true,
                title: const Text('S'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('M'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('L'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('XL'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('XXL'),
                onTap: () {},
              ),
            ],
          ),

          const Divider(),

          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text('Price'),
            children: [

              ListTile(
                dense: true,
                title: const Text('₹500 - ₹1000'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('₹1000 - ₹1500'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('₹1500 - ₹2000'),
                onTap: () {},
              ),

              ListTile(
                dense: true,
                title: const Text('₹2000+'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}