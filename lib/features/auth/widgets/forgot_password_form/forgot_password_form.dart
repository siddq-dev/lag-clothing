import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

enum RecoveryType {
  phone,
  email,
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() =>
      _ForgotPasswordFormState();
}

class _ForgotPasswordFormState
    extends State<ForgotPasswordForm> {

  RecoveryType recoveryType = RecoveryType.phone;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void sendOtp() {

    String destination = recoveryType == RecoveryType.phone
        ? phoneController.text
        : emailController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "OTP will be sent to $destination",
        ),
      ),
    );

    // Later
    // Navigate to OTP Verification Page
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label),

        const SizedBox(height: 10),

        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  "Forgot Password",
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 15),

                const Text(
                  "Choose how you'd like to recover your account.",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 35),

                const Text(
                  "Recover Using",
                ),

                const SizedBox(height: 10),

                RadioListTile<RecoveryType>(
                  value: RecoveryType.phone,
                  groupValue: recoveryType,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "Mobile Number",
                  ),
                  onChanged: (value) {
                    setState(() {
                      recoveryType = value!;
                    });
                  },
                ),

                RadioListTile<RecoveryType>(
                  value: RecoveryType.email,
                  groupValue: recoveryType,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "Email Address",
                  ),
                  onChanged: (value) {
                    setState(() {
                      recoveryType = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                if (recoveryType == RecoveryType.phone)

                  buildField(
                    label: "Mobile Number",
                    controller: phoneController,
                    icon: Icons.phone_outlined,
                    hint: "Enter your mobile number",
                    keyboardType: TextInputType.phone,
                  )

                else

                  buildField(
                    label: "Email Address",
                    controller: emailController,
                    icon: Icons.email_outlined,
                    hint: "Enter your email address",
                    keyboardType:
                        TextInputType.emailAddress,
                  ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: sendOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "SEND OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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