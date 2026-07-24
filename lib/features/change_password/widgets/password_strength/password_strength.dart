import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class PasswordStrength extends StatelessWidget {
  const PasswordStrength({
    super.key,
    required this.password,
  });

  final String password;

  int get strength {
    int value = 0;

    if (password.length >= 8) value++;
    if (password.contains(RegExp(r'[A-Z]'))) value++;
    if (password.contains(RegExp(r'[0-9]'))) value++;
    if (password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) value++;

    return value;
  }

  String get title {
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

  Color get color {
    switch (strength) {
      case 0:
      case 1:
        return Colors.red;

      case 2:
        return Colors.orange;

      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength / 4,
          color: color,
          backgroundColor: Colors.white10,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}