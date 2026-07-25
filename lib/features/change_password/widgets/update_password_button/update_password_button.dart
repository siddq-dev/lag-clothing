import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class UpdatePasswordButton extends StatelessWidget {
  const UpdatePasswordButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        child: const Text(
          "Update Password",
        ),
      ),
    );
  }
}