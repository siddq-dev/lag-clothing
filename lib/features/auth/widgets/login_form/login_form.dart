import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/auth_repository.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/google_auth_service.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool isLoading = false;

  final TextEditingController _userController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_userController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await context.read<AuthProvider>().login(
      email: _userController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      context.go(AppRouter.roleRedirect);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.read<AuthProvider>().error ?? "Login Failed"),
        ),
      );
    }
  }

  Future<void> googleLogin() async {
    try {
      setState(() {
        isLoading = true;
      });

      final credential = await GoogleAuthService.signInWithGoogle();

      if (!mounted) return;

      if (credential != null) {
        final firebaseUser = credential.user;

        if (firebaseUser != null) {
          final user = await AuthRepository.getUser(firebaseUser.uid);

          if (!mounted) return;

          if (user != null) {
            context.read<AuthProvider>().setCurrentUser(user);
          }
        }

        if (!mounted) return;

        context.go(AppRouter.roleRedirect);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign In", style: AppTextStyles.heading2),

                const SizedBox(height: 12),

                const Text(
                  "Welcome back! Please login to continue.",
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 40),

                const Text("Email Address"),

                const SizedBox(height: 10),

                TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text("Password"),

                const SizedBox(height: 10),

                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text("Remember Me"),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        context.go(AppRouter.forgotPassword);
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : googleLogin,
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text("Continue with Google"),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.apple),
                    label: const Text("Continue with Apple"),
                  ),
                ),

                const SizedBox(height: 35),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          context.go(AppRouter.register);
                        },
                        child: const Text("Create Account"),
                      ),
                    ],
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
