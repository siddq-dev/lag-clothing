import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/account_settings_provider.dart';
import '../widgets/account_settings_header.dart';
import '../widgets/account_setting_tile.dart';
import '../widgets/logout_button.dart';
import '../widgets/delete_account_button.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AccountSettingsProvider>().loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,

        foregroundColor: Colors.white,

        title: const Text("Account Settings"),
      ),

      body: Consumer<AccountSettingsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = provider.settings;

          if (settings == null) {
            return const Center(
              child: Text(
                "No settings found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const AccountSettingsHeader(),

                const SizedBox(height: 20),

                AccountSettingTile(
                  title: "Private Account",

                  subtitle: "Only approved users can view your profile",

                  value: settings.privateAccount,

                  onChanged: (value) {
                    provider.updatePrivateAccount(value);
                  },
                ),

                AccountSettingTile(
                  title: "Personalized Ads",

                  subtitle: "Allow personalized recommendations",

                  value: settings.personalizedAds,

                  onChanged: (value) {
                    provider.updatePersonalizedAds(value);
                  },
                ),

                AccountSettingTile(
                  title: "Biometric Login",

                  subtitle: "Use fingerprint or face unlock",

                  value: settings.biometricLogin,

                  onChanged: (value) {
                    provider.updateBiometricLogin(value);
                  },
                ),

                const SizedBox(height: 30),

                const LogoutButton(),

                const SizedBox(height: 15),

                const DeleteAccountButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
