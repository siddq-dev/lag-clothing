import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class NotificationFilter extends StatelessWidget {
  const NotificationFilter({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final Function(int) onChanged;

  static const filters = [
    "All",
    "Orders",
    "Products",
    "Offers",
    "Wishlist",
    "Account",
  ];

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {

          final selected = selectedIndex == index;

          return ChoiceChip(
            label: Text(filters[index]),
            selected: selected,
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(
              color: selected
                  ? Colors.white
                  : Colors.black,
            ),
            onSelected: (_) => onChanged(index),
          );
        },
      ),
    );
  }
}