import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/shop_provider.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

import 'filter_section.dart';

class ShopSidebar extends StatelessWidget {
  const ShopSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShopProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // TITLE
          // ==========================================================
          Text(
            'FILTERS',
            style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
          ),

          const SizedBox(height: 12),

          // ==========================================================
          // CATEGORY
          // ==========================================================
          FilterSection(
            title: 'Category',
            options: provider.categories,
            selectedValues: provider.selectedCategories,
            onChanged: provider.toggleCategory,
          ),

          const Divider(),

          // ==========================================================
          // SIZE
          // ==========================================================
          FilterSection(
            title: 'Size',
            options: const ['S', 'M', 'L', 'XL', 'XXL'],
            selectedValues: provider.selectedSizes,
            onChanged: provider.toggleSize,
          ),

          const Divider(),

          // ==========================================================
          // PRICE
          // ==========================================================
          FilterSection(
            title: 'Price',
            options: const [
              '₹500 - ₹1000',
              '₹1000 - ₹1500',
              '₹1500 - ₹2000',
              '₹2000+',
            ],
            selectedValues: provider.selectedPrices,
            onChanged: provider.togglePrice,
          ),

          const Divider(),

          // ==========================================================
          // BRAND
          // ==========================================================
          FilterSection(
            title: 'Brand',
            options: provider.brands,
            selectedValues: provider.selectedBrands,
            onChanged: provider.toggleBrand,
          ),

          const Divider(),

          // ==========================================================
          // AVAILABILITY
          // ==========================================================
          FilterSection(
            title: 'Availability',
            options: const ['In Stock', 'Out of Stock'],
            selectedValues: provider.selectedAvailability,
            onChanged: provider.toggleAvailability,
          ),
        ],
      ),
    );
  }
}
