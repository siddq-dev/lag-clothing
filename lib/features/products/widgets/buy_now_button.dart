import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    super.key,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
  });

  final ProductModel product;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: product.stock > 0 && product.status
          ? () {
              // TODO
              // Checkout directly
            }
          : null,
      child: const Text(
        "BUY NOW",
      ),
    );
  }
}