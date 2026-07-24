import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class AddPaymentButton extends StatelessWidget {
  const AddPaymentButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(

        onPressed: onPressed,

        icon: const Icon(Icons.add),

        label: const Text(
          "Add Payment Method",
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),

      ),
    );
  }
}