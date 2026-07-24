import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() =>
      _ResetPasswordFormState();
}

class _ResetPasswordFormState
    extends State<ResetPasswordForm> {

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  int get strength {

    int score = 0;

    final password = passwordController.text;

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

      default:
        return Colors.green;
    }
  }

  String get strengthText {

    switch (strength) {

      case 0:
      case 1:
        return "Weak";

      case 2:
        return "Medium";

      default:
        return "Strong";
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
                  "Reset Password",
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 12),

                const Text(
                  "Create a new secure password.",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 35),

                passwordField(
                  label: "New Password",
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
                  controller: confirmController,
                  obscure: obscureConfirm,
                  toggle: () {
                    setState(() {
                      obscureConfirm = !obscureConfirm;
                    });
                  },
                ),

                const SizedBox(height: 25),

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

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password Reset Successfully",
                          ),
                        ),
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "RESET PASSWORD",
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