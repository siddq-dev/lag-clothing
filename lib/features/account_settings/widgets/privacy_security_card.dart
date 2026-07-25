import 'package:flutter/material.dart';

import 'settings_tile.dart';

class PrivacySecurityCard extends StatelessWidget {
  const PrivacySecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              "Privacy & Security",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),

          SettingsTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            subtitle: "Update your password",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.security,
            title: "Two Factor Authentication",
            subtitle: "Coming Soon",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.devices,
            title: "Manage Devices",
            subtitle: "Coming Soon",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            subtitle: "Read our privacy policy",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.description_outlined,
            title: "Terms & Conditions",
            subtitle: "Read terms of service",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
