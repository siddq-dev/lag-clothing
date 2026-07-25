import 'package:flutter/material.dart';

import 'settings_tile.dart';

class LanguageCurrencyCard extends StatelessWidget {
  const LanguageCurrencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              "Language & Region",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),

          SettingsTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "English",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.currency_rupee,
            title: "Currency",
            subtitle: "INR",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.public,
            title: "Country",
            subtitle: "India",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
