import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/profile_photo/profile_photo.dart';
import '../widgets/personal_form/personal_form.dart';
import '../widgets/address_card/address_card.dart';
import '../widgets/password_card/password_card.dart';
import '../widgets/save_button/save_button.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Page Title
                  Row(
                    children: [

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 35),

                  /// Profile Photo
                  const ProfilePhoto(),

                  const SizedBox(height: 30),

                  /// Personal Information Form
                  const PersonalForm(),

                  const SizedBox(height: 30),

                  /// Address
                  const AddressCard(),

                  const SizedBox(height: 30),

                  /// Password
                  const PasswordCard(),

                  const SizedBox(height: 40),

                  /// Save Button
                  const SaveButton(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}