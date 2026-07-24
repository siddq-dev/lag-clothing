import 'package:flutter/material.dart';

import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

import 'package:lag_clothing/features/change_password/widgets/password_strength/password_strength.dart';
import 'package:lag_clothing/features/change_password/widgets/update_password_button/update_password_button.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool currentHidden = true;
  bool newHidden = true;
  bool confirmHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _passwordField(
          "Current Password",
          currentController,
          currentHidden,
          () {
            setState(() {
              currentHidden = !currentHidden;
            });
          },
        ),

        const SizedBox(height: AppSpacing.xl),

        _passwordField(
          "New Password",
          newController,
          newHidden,
          () {
            setState(() {
              newHidden = !newHidden;
            });
          },
        ),

        const SizedBox(height: 12),

        PasswordStrength(
          password: newController.text,
        ),

        const SizedBox(height: AppSpacing.xl),

        _passwordField(
          "Confirm Password",
          confirmController,
          confirmHidden,
          () {
            setState(() {
              confirmHidden = !confirmHidden;
            });
          },
        ),

        const SizedBox(height: AppSpacing.xl),

        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              Text("✓ Minimum 8 Characters"),
              SizedBox(height: 4),

              Text("✓ One Uppercase Letter"),
              SizedBox(height: 4),

              Text("✓ One Number"),
              SizedBox(height: 4),

              Text("✓ One Special Character"),

            ],
          ),
        ),

        const SizedBox(height: 35),

        UpdatePasswordButton(
          onPressed: () {},
        ),

      ],
    );
  }

  Widget _passwordField(
    String label,
    TextEditingController controller,
    bool hidden,
    VoidCallback toggle,
  ) {
    return TextField(
      controller: controller,
      obscureText: hidden,
      onChanged: (_) {
        setState(() {});
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            hidden
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}