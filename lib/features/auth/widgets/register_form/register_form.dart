import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agree = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscure = false,
    VoidCallback? toggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label),

        const SizedBox(height: 10),

        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),

            suffixIcon: toggle == null
                ? null
                : IconButton(
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
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Email",
                  controller: emailController,
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Phone Number",
                  controller: phoneController,
                  icon: Icons.phone_outlined,
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Password",
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  obscure: obscurePassword,
                  toggle: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Confirm Password",
                  controller: confirmPasswordController,
                  icon: Icons.lock_outline,
                  obscure: obscureConfirmPassword,
                  toggle: () {
                    setState(() {
                      obscureConfirmPassword =
                          !obscureConfirmPassword;
                    });
                  },
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "CREATE ACCOUNT",
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
                      onPressed: () {},
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