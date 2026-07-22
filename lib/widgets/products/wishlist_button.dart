import 'package:flutter/material.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.favorite_border,
      ),
    );
  }
}