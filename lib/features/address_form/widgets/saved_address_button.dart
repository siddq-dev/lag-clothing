import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class SaveAddressButton extends StatelessWidget {
  const SaveAddressButton({
    super.key,
    required this.isEditing,
    required this.onPressed,
  });

  final bool isEditing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          isEditing
              ? "Update Address"
              : "Save Address",
        ),
      ),
    );
  }
}