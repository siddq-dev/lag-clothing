import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../themes/app_colors.dart';

import 'nav_actions.dart';
import 'nav_logo.dart';
import 'nav_menu.dart';

class WebsiteNavigationBar extends StatelessWidget {
  const WebsiteNavigationBar({
    super.key,
    required this.selectedItem,
    required this.onMenuSelected,
    required this.onSearch,
    required this.onWishlist,
    required this.onCart,
    required this.onSignIn,
    this.currentUser,
  });

  final String selectedItem;
  final ValueChanged<String> onMenuSelected;

  final VoidCallback onSearch;
  final VoidCallback onWishlist;
  final VoidCallback onCart;
  final VoidCallback onSignIn;

  final UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          const NavLogo(),

          const Spacer(),

          NavMenu(selectedItem: selectedItem, onItemSelected: onMenuSelected),

          const Spacer(),

          NavActions(
            onSearch: onSearch,
            onWishlist: onWishlist,
            onCart: onCart,
            onSignIn: onSignIn,
            currentUser: currentUser,
          ),
        ],
      ),
    );
  }
}
