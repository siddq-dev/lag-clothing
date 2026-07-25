import 'package:flutter/material.dart';

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

  /// Page content
  final Widget child;

  /// Current selected navigation item
  final String currentRoute;

  /// Forms/About/Contact -> true
  /// Dashboard/List Pages -> false
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
              onMenuSelected: (route) {
                // Navigation later
              },
              onSearch: () {
                // Search later
              },
              onCart: () {
                // Cart later
              },
              onSignIn: () {
                // Login later
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
                        Expanded(
                          child: child,
                        ),
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