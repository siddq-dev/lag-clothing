import 'package:flutter/material.dart';

import '../../models/navigation_items.dart';
import '../../routes/app_routes.dart';


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
  NavigationItems(
    title: 'Home',
    route: AppRouter.home,
  ),
  NavigationItems(
    title: 'Shop',
    route: AppRouter.shop,
  ),
  NavigationItems(
    title: 'About Us',
    route: AppRouter.about,
  ),
  NavigationItems(
    title: 'Contact Us',
    route: AppRouter.contact,
  ),
];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: menuItems.map((item) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: NavItem(
      title: item.title,
      isSelected: selectedItem == item.route,
      onTap: () => onItemSelected(item.route),
    ),
  );
}).toList(),
    );
  }
}