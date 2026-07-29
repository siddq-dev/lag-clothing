import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
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
    return ElevatedButton(
     onPressed: product.stock > 0 && product.status
          ? () {
              // TODO
              // Add to Cart Provider
            }
          : null,
      child: const Text(
        "ADD TO CART",
      ),
    );
  }
}