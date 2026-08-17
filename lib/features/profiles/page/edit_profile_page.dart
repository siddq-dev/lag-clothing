import 'package:flutter/material.dart';

import '../../../../layout/website_layout.dart';
import '../../../../routes/app_routes.dart';

import '../widgets/edit_profile_form.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
        child: Center(
          child: SizedBox(
            width: 900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),

                Text(
                  "Update your personal information.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                SizedBox(height: 40),

                EditProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
