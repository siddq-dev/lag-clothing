import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

import 'product_price.dart';
import 'product_rating.dart';
import 'product_size_selector.dart';
import 'product_color_selector.dart';
import 'quantity_selector.dart';
import 'add_to_cart_button.dart';
import 'buy_now_button.dart';

class ProductInformation extends StatefulWidget {
  const ProductInformation({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductInformation> createState() =>
      _ProductInformationState();
}

class _ProductInformationState
    extends State<ProductInformation> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;

  @override
void initState() {
  super.initState();

  if (widget.product.variants.isNotEmpty) {
    selectedSize = widget.product.variants.first.size;
    selectedColor = widget.product.variants.first.color;
  }
}

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          product.brand,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          product.name,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        ProductRating(
          rating: product.rating,
        ),

        const SizedBox(height: 20),

        ProductPrice(
          price: product.price,
          salePrice: product.salePrice,
        ),

        const SizedBox(height: 20),

    Text(
  product.stock > 0
      ? "In Stock (${product.stock})"
      : "Out of Stock",
  style: TextStyle(
    color: product.stock > 0
        ? Colors.green
        : Colors.red,
    fontWeight: FontWeight.bold,
  ),
),

        const SizedBox(height: 15),

  Text(
  selectedSize == null
      ? ""
      : "SKU : ${product.variants.firstWhere(
          (variant) =>
              variant.size == selectedSize &&
              variant.color == selectedColor,
          orElse: () => product.variants.first,
        ).sku}",
),

        const SizedBox(height: 30),

       ProductSizeSelector(
 sizes: product.variants
    .map((variant) => variant.size)
    .toSet()
    .toList(),
          selectedSize: selectedSize,
          onChanged: (value) {
            setState(() {
              selectedSize = value;
            });
          },
        ),

        const SizedBox(height: 25),

        ProductColorSelector(
colors: product.variants
    .where(
      (variant) =>
          variant.size == selectedSize,
    )
    .map((variant) => variant.color)
    .toSet()
    .toList(),
          selectedColor: selectedColor,
          onChanged: (value) {
  setState(() {
    selectedSize = value;

    final colors = product.variants
        .where(
          (variant) =>
              variant.size == value,
        )
        .map((variant) => variant.color)
        .toList();

    if (colors.isNotEmpty) {
      selectedColor = colors.first;
    }
  });
},
        ),

        const SizedBox(height: 25),

        QuantitySelector(
          quantity: quantity,
          onChanged: (value) {
            setState(() {
              quantity = value;
            });
          },
        ),

        const SizedBox(height: 35),

        SizedBox(
          width: double.infinity,
          child: AddToCartButton(
            product: product,
            quantity: quantity,
            selectedColor: selectedColor,
            selectedSize: selectedSize,
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          width: double.infinity,
          child: BuyNowButton(
            product: product,
            quantity: quantity,
            selectedColor: selectedColor,
            selectedSize: selectedSize,
          ),
        ),
      ],
    );
  }
}