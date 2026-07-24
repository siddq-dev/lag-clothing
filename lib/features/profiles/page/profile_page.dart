import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/profile_header/profile_header.dart';
import '../widgets/quick_stats/quick_stats.dart';
import '../widgets/menu_section/menu_section.dart';
import '../widgets/logout_button/logout_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 50,
          ),
          child: Center(
            child: SizedBox(
              width: 1100,
              child: Column(
                children: [

                  ProfileHeader(),

                  SizedBox(height: 35),

                  QuickStats(),

                  SizedBox(height: 40),

                  MenuSection(),

                  SizedBox(height: 35),

                  LogoutButton(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}