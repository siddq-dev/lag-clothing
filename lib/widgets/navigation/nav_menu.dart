import 'package:flutter/material.dart';

import '../../models/navigation_items.dart';
import '../../routes/app_router.dart';

import 'nav_item.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  final String selectedItem;
  final ValueChanged<String> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      'Home',
      'Shop',
      'About us',
      'Contact',
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: menuItems.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: NavItem(
            title: item,
            isSelected: selectedItem == item,
            onTap: () => onItemSelected(item),
          ),
        );
      }).toList(),
    );
  }
}