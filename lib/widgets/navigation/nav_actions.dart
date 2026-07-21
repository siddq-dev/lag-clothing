import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class NavActions extends StatelessWidget {
  const NavActions({
    super.key,
    required this.onSearch,
    required this.onCart,
    required this.onSignIn,
  });

  final VoidCallback onSearch;
  final VoidCallback onCart;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onSearch,
          icon: const Icon(
            Icons.search,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(width: 8),

        IconButton(
          onPressed: onCart,
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(width: 12),

        TextButton(
          onPressed: onSignIn,
          child: const Text("Sign In"),
        ),
      ],
    );
  }
}