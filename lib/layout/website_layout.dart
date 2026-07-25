import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../themes/app_colors.dart';
import '../widgets/footers/footer.dart';
import '../widgets/navigation/navigation_bar.dart';

class WebsiteLayout extends StatelessWidget {
  const WebsiteLayout({
    super.key,
    required this.child,
    required this.currentRoute,
    this.scrollable = true,
  });

  final Widget child;
  final String currentRoute;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            WebsiteNavigationBar(
              selectedItem: currentRoute,

              // ✅ Main Navigation
              onMenuSelected: (route) {
                context.go(route);
              },

              // ✅ Search (temporary)
              onSearch: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Search page coming soon'),
                  ),
                );
              },

              // ✅ Cart
              onCart: () {
                context.go(AppRouter.cart);
              },

              // ✅ Profile/Login
              onSignIn: () {
                context.go(AppRouter.login);
              },
            ),

            Expanded(
              child: scrollable
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          child,
                          const Footer(),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(child: child),
                        const Footer(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}