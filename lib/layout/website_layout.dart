import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
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
    final authProvider = context.watch<AuthProvider>();
    final currentUser = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            WebsiteNavigationBar(
              selectedItem: currentRoute,
              currentUser: currentUser,

              onMenuSelected: (route) {
                context.go(route);
              },

              onSearch: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search page coming soon')),
                );
              },

              onWishlist: () {
                context.go(AppRouter.wishlist);
              },

              onCart: () {
                context.go(AppRouter.cart);
              },

              onSignIn: () {
                if (currentUser != null) {
                  context.go(AppRouter.profile);
                } else {
                  context.go(AppRouter.login);
                }
              },
            ),

            Expanded(
              child: scrollable
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [child, const Footer()]),
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
