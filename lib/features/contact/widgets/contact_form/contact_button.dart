import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        child: const Text(
          'Contact Our Team',
        ),
      ),
    );
  }
}