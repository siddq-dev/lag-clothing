import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

enum VerificationType {
  phone,
  email,
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  bool agree = false;

  VerificationType verificationType = VerificationType.phone;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
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
            hintText: hint,
            prefixIcon: Icon(icon),
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
                  "Create Account",
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 10),

                const Text(
                  "Join the LAG community.",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 35),

                buildField(
                  label: "Full Name",
                  controller: nameController,
                  icon: Icons.person_outline,
                  hint: "Enter your full name",
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Email Address",
                  controller: emailController,
                  icon: Icons.email_outlined,
                  hint: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Mobile Number",
                  controller: phoneController,
                  icon: Icons.phone_outlined,
                  hint: "Enter your mobile number",
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 30),

                Text(
                  "Verify Using",
                  style: AppTextStyles.bodyLarge,
                ),

                const SizedBox(height: 10),

                RadioListTile<VerificationType>(
                  value: VerificationType.phone,
                  groupValue: verificationType,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "Mobile Number",
                  ),
                  onChanged: (value) {
                    setState(() {
                      verificationType = value!;
                    });
                  },
                ),

                RadioListTile<VerificationType>(
                  value: VerificationType.email,
                  groupValue: verificationType,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "Email Address",
                  ),
                  onChanged: (value) {
                    setState(() {
                      verificationType = value!;
                    });
                  },
                ),

                const SizedBox(height: 10),

                CheckboxListTile(
                  value: agree,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "I agree to the Terms & Privacy Policy",
                  ),
                  onChanged: (value) {
                    setState(() {
                      agree = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: agree
                        ? () {
                            // Navigate to OTP Verification
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Already have an account?",
                    ),

                    TextButton(
                      onPressed: () {
                        // Navigate to Login
                      },
                      child: const Text(
                        "LOGIN",
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}