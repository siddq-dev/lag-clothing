import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class ShopSearch extends StatelessWidget {
  const ShopSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 420,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Jerseys...',
            prefixIcon: const Icon(Icons.search),

            filled: true,
            fillColor: AppColors.surface,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.border,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}