import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../themes/app_colors.dart';

class NavActions extends StatelessWidget {
  const NavActions({
    super.key,
    required this.onSearch,
    required this.onWishlist,
    required this.onCart,
    required this.onSignIn,
    this.currentUser,
  });

  final VoidCallback onSearch;
  final VoidCallback onWishlist;
  final VoidCallback onCart;
  final VoidCallback onSignIn;

  final UserModel? currentUser;

  String _userInitial() {
    final name = currentUser?.name.trim() ?? '';

    if (name.isEmpty) {
      return '?';
    }

    return name.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // =========================
        // SEARCH
        // =========================
        IconButton(
          onPressed: onSearch,
          icon: const Icon(Icons.search, color: AppColors.textPrimary),
        ),

        const SizedBox(width: 8),

        // =========================
        // WISHLIST
        // =========================
        IconButton(
          onPressed: onWishlist,
          icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary),
        ),

        const SizedBox(width: 8),

        // =========================
        // CART
        // =========================
        IconButton(
          onPressed: onCart,
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(width: 12),

        // =========================
        // SIGN IN / USER PROFILE
        // =========================
        if (currentUser == null)
          TextButton(onPressed: onSignIn, child: const Text("Sign In"))
        else
          InkWell(
            onTap: onSignIn,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Text(
                _userInitial(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
