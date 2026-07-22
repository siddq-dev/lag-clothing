import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../widgets/footers/footer.dart';
import '../widgets/navigation/navigation_bar.dart';

class WebsiteLayout extends StatelessWidget {
  const WebsiteLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  /// Page content
  final Widget child;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ===========================
            // Navigation Bar
            // ===========================
           WebsiteNavigationBar(
  selectedItem: currentRoute,

  onMenuSelected: (route) {
    // Navigation will be connected later
  },

  onSearch: () {
    // Search functionality later
  },

  onCart: () {
    // Cart page later
  },

  onSignIn: () {
    // Sign In later
  },
),

            // ===========================
            // Page Content
            // ===========================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    child,

                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}