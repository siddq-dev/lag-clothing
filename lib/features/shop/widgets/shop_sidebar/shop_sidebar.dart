import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';
import 'filter_section.dart';

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
const FilterSection(
  title: "Category",
  options: [
    "Club Jerseys",
    "National Jerseys",
    "Retro Jerseys",
    "Training Kits",
    "Goalkeeper Jerseys",
  ],
),

Divider(),

FilterSection(
  title: "Size",
  options: [
    "S",
    "M",
    "L",
    "XL",
    "XXL",
  ],
),

Divider(),

FilterSection(
  title: "Price",
  options: [
    "₹500 - ₹1000",
    "₹1000 - ₹1500",
    "₹1500 - ₹2000",
    "₹2000+",
  ],
),

Divider(),

FilterSection(
  title: "Brand",
  options: [
    "LAG",
    "Nike",
    "Adidas",
    "Puma",
  ],
),

Divider(),

FilterSection(
  title: "Availability",
  options: [
    "In Stock",
    "Out of Stock",
  ],
),
        ],
      ),
    );
  }
}