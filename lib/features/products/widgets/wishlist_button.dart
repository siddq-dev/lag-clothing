import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black54,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.favorite_border,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () {
          // TODO
          // Add to Wishlist
        },
      ),
    );
  }
}