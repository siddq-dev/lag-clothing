import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/auth_service.dart';
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
  bool isLoading = false;

  VerificationType verificationType = VerificationType.email;

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

  Future<void> register() async {
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please accept Terms & Privacy Policy"),
        ),
      );
      return;
    }

    if (verificationType == VerificationType.phone) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone verification coming soon."),
        ),
      );
      return;
    }

    if (nameController.text.trim().isEmpty ||
    emailController.text.trim().isEmpty ||
    phoneController.text.trim().isEmpty ||
    passwordController.text.trim().isEmpty ||
    confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields."),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match."),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

   await AuthService.register(
  fullName: nameController.text.trim(),
  email: emailController.text.trim(),
  phone: phoneController.text.trim(),
  password: passwordController.text.trim(),
);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully."),
        ),
      );

      context.go(AppRouter.profile);
    } on FirebaseAuthException catch (e) {
      String message = "Registration Failed";

      switch (e.code) {
        case "email-already-in-use":
          message = "Email already registered.";
          break;

        case "invalid-email":
          message = "Invalid email address.";
          break;

        case "weak-password":
          message = "Password is too weak.";
          break;

        default:
          message = e.message ?? message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscureText = false,
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
          obscureText: obscureText,
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

                const SizedBox(height: 20),

                buildField(
                  label: "Password",
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  hint: "Enter password",
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                buildField(
                  label: "Confirm Password",
                  controller: confirmPasswordController,
                  icon: Icons.lock_outline,
                  hint: "Confirm password",
                  obscureText: true,
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
                    "Mobile Number (Coming Soon)",
                  ),
                  onChanged: (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Phone verification coming soon.",
                        ),
                      ),
                    );
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
                    onPressed: isLoading ? null : register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
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
                        context.go(AppRouter.login);
                      },
                      child: const Text("LOGIN"),
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