import 'package:flutter/material.dart';

import '../../models/feature_product_model.dart';
import '../../themes/app_colors.dart';

import 'add_to_cart_button.dart';
import 'product_image.dart';
import 'product_info.dart';
import 'product_price.dart';
import 'product_rating.dart';
import 'wishlist_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    required this.onWishlist,
  });

  final ProductModel product;

  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final VoidCallback onWishlist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
      child: Column(
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ProductImage(
                image: product.image,
                isNew: product.isNew,
              ),

              Positioned(
                top: 0,
                right: 0,
                child: WishlistButton(
                  onPressed: onWishlist,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ProductInfo(
            club: product.club,
            title: product.title,
          ),

          const SizedBox(height: 16),

          ProductPrice(
            price: product.price,
          ),

          const SizedBox(height: 8),

          ProductRating(
            rating: product.rating,
          ),
        ],
      ),
    ),

    const SizedBox(height: 16),

    AddToCartButton(
      onPressed: onAddToCart,
    ),
  ],
)
      ),
    );
  }
}