import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/customer_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerProvider>().loadCustomer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();

    if (provider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Text(provider.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    final customer = provider.customer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            "MY ACCOUNT",
            style: AppTextStyles.heading1.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 30),

          Stack(
            children: [
              customer?.photoUrl != null && customer!.photoUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(customer.photoUrl),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.white, size: 55),
                    ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      // TODO:
                      // Image Picker
                      // Upload to Firebase Storage
                      // provider.updatePhoto(downloadUrl);
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Text(
            customer?.fullName ?? "Loading...",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 8),

          Text(
            customer?.email ?? "",
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            customer?.phone ?? "",
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade500,
            ),
          ),

          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: () {
              context.go(AppRouter.editProfile);
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text("Edit Profile"),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
