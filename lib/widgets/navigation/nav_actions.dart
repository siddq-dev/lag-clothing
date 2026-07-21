import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class NavActions extends StatelessWidget {
  const NavActions({
    super.key,
    required this.onSearch,
    required this.onCart,
    required this.onLogin,
  });

  final VoidCallback onSearch;
  final VoidCallback onCart;
  final VoidCallback onLogin;

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
          onPressed: onLogin,
          child: const Text("Login"),
        ),
      ],
    );
  }
}