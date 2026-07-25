import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class ApplyCouponButton extends StatelessWidget {
  const ApplyCouponButton({
    super.key,
    required this.onPressed,
    this.text = "APPLY COUPON",
    this.icon = Icons.local_offer_outlined,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}