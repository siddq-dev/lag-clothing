import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class CreatePasswordForm extends StatefulWidget {
  const CreatePasswordForm({super.key});

  @override
  State<CreatePasswordForm> createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  int get strength {

    final password = passwordController.text;

    int score = 0;

    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) score++;

    return score;
  }

  Color get strengthColor {

    switch (strength) {

      case 0:
      case 1:
        return Colors.red;

      case 2:
        return Colors.orange;

      case 3:
      case 4:
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  String get strengthText {

    switch (strength) {

      case 0:
      case 1:
        return "Weak";

      case 2:
        return "Medium";

      case 3:
      case 4:
        return "Strong";

      default:
        return "";
    }
  }

  Widget passwordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
  }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label),

        const SizedBox(height: 10),

        TextField(
          controller: controller,
          obscureText: obscure,

          onChanged: (_) {
            setState(() {});
          },

          decoration: InputDecoration(

            prefixIcon: const Icon(Icons.lock_outline),

            suffixIcon: IconButton(
              onPressed: toggle,
              icon: Icon(
                obscure
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),

          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.background,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Create Password",
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 12),

                const Text(
                  "Create a secure password for your account.",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 35),

                passwordField(
                  label: "Password",
                  controller: passwordController,
                  obscure: obscurePassword,
                  toggle: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),

                const SizedBox(height: 20),

                LinearProgressIndicator(
                  value: strength / 4,
                  color: strengthColor,
                  backgroundColor: Colors.white12,
                ),

                const SizedBox(height: 8),

                Text(
                  strengthText,
                  style: TextStyle(
                    color: strengthColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                passwordField(
                  label: "Confirm Password",
                  controller: confirmPasswordController,
                  obscure: obscureConfirm,
                  toggle: () {
                    setState(() {
                      obscureConfirm = !obscureConfirm;
                    });
                  },
                ),

                const SizedBox(height: 30),

                const Text("Password must contain:"),

                const SizedBox(height: 10),

                const Text("✓ Minimum 8 characters"),
                const Text("✓ One uppercase letter"),
                const Text("✓ One number"),
                const Text("✓ One special character"),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Create Account
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}