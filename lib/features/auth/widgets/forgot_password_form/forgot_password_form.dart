import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() =>
      _ForgotPasswordFormState();
}

class _ForgotPasswordFormState
    extends State<ForgotPasswordForm> {

  final TextEditingController emailController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Password reset link has been sent to your email.",
        ),
      ),
    );

    // Firebase implementation later
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  "Forgot Password",
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 15),

                const Text(
                  "Enter your registered email address and we'll send you a password reset link.",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 40),

                const Text("Email Address"),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    hintText:
                        "Enter your email address",
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "SEND RESET LINK",
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to Login",
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