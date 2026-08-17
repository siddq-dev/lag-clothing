import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../routes/app_routes.dart';
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

  // ============================================================
  // MOBILE NAVIGATION ITEMS
  // ============================================================

  List<_MobileNavItem> _navigationItems() {
    return [
      const _MobileNavItem(
        title: 'Home',
        icon: Icons.home_outlined,
        route: AppRouter.home,
      ),

      const _MobileNavItem(
        title: 'Shop',
        icon: Icons.shopping_bag_outlined,
        route: AppRouter.shop,
      ),

      const _MobileNavItem(
        title: 'Wishlist',
        icon: Icons.favorite_border,
        route: AppRouter.wishlist,
      ),

      const _MobileNavItem(
        title: 'Cart',
        icon: Icons.shopping_cart_outlined,
        route: AppRouter.cart,
      ),

      const _MobileNavItem(
        title: 'Contact Us',
        icon: Icons.contact_mail_outlined,
        route: AppRouter.contact,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;

    if (isMobile) {
      return _buildMobileNavigation(context);
    }

    return _buildDesktopNavigation(context);
  }

  // ============================================================
  // DESKTOP NAVIGATION
  // ============================================================

  Widget _buildDesktopNavigation(BuildContext context) {
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

  // ============================================================
  // MOBILE NAVIGATION
  // ============================================================

  Widget _buildMobileNavigation(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          // ======================================================
          // HAMBURGER
          // ======================================================
          IconButton(
            tooltip: 'Menu',
            icon: const Icon(Icons.menu, size: 26),
            onPressed: () {
              _openMobileDrawer(context);
            },
          ),

          // ======================================================
          // LOGO
          // ======================================================
          const Expanded(child: Center(child: NavLogo())),

          // ======================================================
          // WISHLIST
          // ======================================================
          IconButton(
            tooltip: 'Wishlist',
            icon: const Icon(Icons.favorite_border, size: 22),
            onPressed: onWishlist,
          ),

          // ======================================================
          // CART
          // ======================================================
          IconButton(
            tooltip: 'Cart',
            icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            onPressed: onCart,
          ),

          // ======================================================
          // PROFILE / LOGIN
          // ======================================================
          _buildMobileProfileButton(context),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE PROFILE BUTTON
  // ============================================================

  Widget _buildMobileProfileButton(BuildContext context) {
    // ----------------------------------------------------------
    // NOT LOGGED IN
    // ----------------------------------------------------------

    if (currentUser == null) {
      return IconButton(
        tooltip: 'Login',
        onPressed: onSignIn,
        icon: const CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person_outline, color: Colors.white, size: 19),
        ),
      );
    }

    // ----------------------------------------------------------
    // LOGGED IN
    // ----------------------------------------------------------

    final name = currentUser!.name.trim();

    final initial = name.isNotEmpty ? name.substring(0, 1).toUpperCase() : 'U';

    return IconButton(
      tooltip: 'Profile',
      onPressed: onSignIn,
      icon: CircleAvatar(
        radius: 15,
        backgroundColor: AppColors.primary,
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // OPEN MOBILE MENU
  // ============================================================

  void _openMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _MobileNavigationSheet(
          selectedItem: selectedItem,
          items: _navigationItems(),
          onSelected: (route) {
            Navigator.of(sheetContext).pop();

            if (route != selectedItem) {
              onMenuSelected(route);
            }
          },
        );
      },
    );
  }
}

// ================================================================
// MOBILE NAVIGATION ITEM
// ================================================================

class _MobileNavItem {
  const _MobileNavItem({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;
}

// ================================================================
// MOBILE NAVIGATION SHEET
// ================================================================

class _MobileNavigationSheet extends StatelessWidget {
  const _MobileNavigationSheet({
    required this.selectedItem,
    required this.items,
    required this.onSelected,
  });

  final String selectedItem;
  final List<_MobileNavItem> items;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          color: Color(0xFF111111),

          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),

        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ====================================================
            // HANDLE
            // ====================================================
            Center(
              child: Container(
                width: 42,
                height: 4,

                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // MENU TITLE
            // ====================================================
            const Text(
              'MENU',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 10),

            // ====================================================
            // MENU ITEMS
            // ====================================================
            ...items.map((item) {
              final isSelected = selectedItem == item.route;

              return Padding(
                padding: const EdgeInsets.only(bottom: 4),

                child: Material(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.14)
                      : Colors.transparent,

                  borderRadius: BorderRadius.circular(12),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),

                    onTap: () {
                      onSelected(item.route);
                    },

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),

                      child: Row(
                        children: [
                          // ==================================
                          // ICON
                          // ==================================
                          Icon(
                            item.icon,
                            size: 22,

                            color: isSelected
                                ? AppColors.primary
                                : Colors.white,
                          ),

                          const SizedBox(width: 14),

                          // ==================================
                          // TITLE
                          // ==================================
                          Expanded(
                            child: Text(
                              item.title,

                              style: TextStyle(
                                fontSize: 16,

                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,

                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.white,
                              ),
                            ),
                          ),

                          // ==================================
                          // SELECTED INDICATOR
                          // ==================================
                          if (isSelected)
                            Container(
                              width: 7,
                              height: 7,

                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 8),

            // ====================================================
            // CLOSE BUTTON
            // ====================================================
            SizedBox(
              width: double.infinity,

              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },

                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),

                  side: const BorderSide(color: Colors.white24),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
