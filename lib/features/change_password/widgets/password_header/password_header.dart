import 'package:flutter/material.dart';

import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class PasswordHeader extends StatelessWidget {
  const PasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 10),

            Text(
              "CHANGE PASSWORD",
              style: AppTextStyles.heading1.copyWith(
                color: Colors.white,
              ),
            ),

          ],
        ),

        const SizedBox(height: AppSpacing.md),

        Padding(
          padding: const EdgeInsets.only(left: 52),
          child: Text(
            "Update your account password securely.",
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
        ),

      ],
    );
  }
}