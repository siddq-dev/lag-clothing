import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/shop_provider.dart';
import '../../../../themes/app_colors.dart';

class ShopSearch extends StatelessWidget {
  const ShopSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ShopProvider>();

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 420,
        child: TextField(
          onChanged: provider.updateSearch,
          decoration: InputDecoration(
            hintText: "Search Jerseys...",
            prefixIcon: const Icon(Icons.search),

            suffixIcon: Consumer<ShopProvider>(
              builder: (_, provider, _) {
                if (provider.products.isEmpty) {
                  return const Icon(Icons.search_off);
                }

                return IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    provider.updateSearch("");
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),

            filled: true,
            fillColor: AppColors.surface,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.border),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
