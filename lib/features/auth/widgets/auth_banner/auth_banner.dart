import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        Image.asset(
          'assets/images/auth/login_banner.jpg',
          fit: BoxFit.cover,
        ),

        Container(
          color: Colors.black.withOpacity(0.65),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'LAG',
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.primary,
                  fontSize: 64,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'WELCOME BACK',
                style: AppTextStyles.heading2.copyWith(
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(
                width: 500,
                child: Text(
                  'Sign in to continue exploring premium football jerseys from clubs and nations around the world.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    height: 1.6,
                  ),
                ),
              ),

            ],
          ),
        ),

      ],
    );
  }
}