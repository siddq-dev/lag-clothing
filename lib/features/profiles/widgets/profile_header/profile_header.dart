import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [

          Text(
            "MY ACCOUNT",
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 30),

          Stack(
            children: [

              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 55,
                ),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      // TODO
                      // Change Profile Picture
                    },
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 25),

          Text(
            "John Doe",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 8),

          Text(
            "john@email.com",
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: () {
              // TODO
              // Navigate to Personal Information
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text("Edit Profile"),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(
                color: AppColors.primary,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
            ),
          ),

        ],
      ),
    );
  }
}