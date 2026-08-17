import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routes/app_routes.dart';

class SuperAdminSidebar extends StatelessWidget {
  const SuperAdminSidebar({
    super.key,
    this.isMobile = false,
    this.currentRoute,
    this.onClose,
  });

  /// True when the sidebar is opened on mobile.
  final bool isMobile;

  /// The route of the page currently being displayed.
  final String? currentRoute;

  /// Used to close the mobile sidebar.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final route = currentRoute ?? '';

    return Container(
      width: isMobile ? double.infinity : 260,
      color: Colors.black,
      child: Column(
        children: [
          // ============================================================
          // HEADER
          // ============================================================
          Padding(
            padding: EdgeInsets.only(
              top: isMobile ? 10 : 40,
              left: 20,
              right: 12,
              bottom: isMobile ? 20 : 40,
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: Colors.red, size: 28),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    'LAG Clothing',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (isMobile)
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () {
                      if (onClose != null) {
                        onClose!();
                      } else if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
              ],
            ),
          ),

          // ============================================================
          // MENU
          // ============================================================
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                _tile(
                  context,
                  route,
                  Icons.dashboard_outlined,
                  'Dashboard',
                  AppRouter.superAdminDashboard,
                ),

                _tile(
                  context,
                  route,
                  Icons.admin_panel_settings_outlined,
                  'Admin Management',
                  AppRouter.adminManagement,
                ),

                _tile(
                  context,
                  route,
                  Icons.shopping_bag_outlined,
                  'Manage Products',
                  AppRouter.manageProducts,
                ),

                _tile(
                  context,
                  route,
                  Icons.people_outline,
                  'Customers',
                  AppRouter.customerManagement,
                ),

                _tile(
                  context,
                  route,
                  Icons.receipt_long_outlined,
                  'Orders',
                  AppRouter.adminOrderDetails,
                ),

                _tile(
                  context,
                  route,
                  Icons.analytics_outlined,
                  'Analytics',
                  AppRouter.analytics,
                ),

                _tile(
                  context,
                  route,
                  Icons.inventory_2_outlined,
                  'Inventory',
                  AppRouter.inventory,
                ),

                _tile(
                  context,
                  route,
                  Icons.settings_outlined,
                  'Website Settings',
                  AppRouter.websiteSettings,
                ),

                const SizedBox(height: 12),

                const Divider(
                  color: Colors.white12,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),

                const SizedBox(height: 12),

                _tile(
                  context,
                  route,
                  Icons.logout,
                  'Logout',
                  AppRouter.login,
                  isLogout: true,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SIDEBAR TILE
  // ================================================================

  Widget _tile(
    BuildContext context,
    String route,
    IconData icon,
    String title,
    String targetRoute, {
    bool isLogout = false,
  }) {
    final bool isSelected = route == targetRoute;

    // Current page = RED
    // Logout = RED
    // Other pages = WHITE
    final Color itemColor = isSelected || isLogout ? Colors.red : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Material(
        color: isSelected
            ? Colors.red.withValues(alpha: 0.14)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Close mobile sidebar.
            if (isMobile) {
              if (onClose != null) {
                onClose!();
              } else if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }

            // Navigate only if this isn't the current page.
            if (route != targetRoute) {
              context.go(targetRoute);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

              // Red left indicator for current page.
              border: isSelected
                  ? const Border(left: BorderSide(color: Colors.red, width: 3))
                  : null,
            ),
            child: Row(
              children: [
                Icon(icon, size: 22, color: itemColor),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: itemColor,
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),

                // Small red indicator on selected page.
                if (isSelected && !isLogout)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
