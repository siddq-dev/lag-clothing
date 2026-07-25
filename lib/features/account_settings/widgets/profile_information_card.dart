import 'package:flutter/material.dart';

import 'settings_tile.dart';

class ProfileInformationCard extends StatelessWidget {
  const ProfileInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              "Profile Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),

          SettingsTile(
            icon: Icons.person_outline,
            title: "Edit Profile",
            subtitle: "Update personal information",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.email_outlined,
            title: "Change Email",
            subtitle: "Update email address",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.phone_outlined,
            title: "Change Phone",
            subtitle: "Update phone number",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
