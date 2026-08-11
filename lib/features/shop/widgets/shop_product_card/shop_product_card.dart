import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_model.dart';
import '../../../../models/wishlist_items.dart';
import '../../../../providers/wishlist_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class ShopProductCard extends StatelessWidget {
  const ShopProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : '';

    final displayPrice = product.salePrice > 0
        ? product.salePrice
        : product.price;

    // --------------------------------------------------
    // Navigate to Product Details
    // --------------------------------------------------

    void openProductDetails() {
      context.go('/product/${product.id}');
    }

    // --------------------------------------------------
    // Available Sizes
    // --------------------------------------------------

    final availableSizes = product.variants
        .where((variant) => variant.available)
        .map((variant) => variant.size.trim())
        .where((size) => size.isNotEmpty)
        .toSet()
        .toList();

    // --------------------------------------------------
    // Wishlist state for this product (no size/color
    // picker on the card, so we key on productId only
    // using the default/first available size).
    // --------------------------------------------------

    final defaultSize = availableSizes.isNotEmpty ? availableSizes.first : '';

    final wishlistProvider = context.watch<WishlistProvider>();

    final isWishlisted = wishlistProvider.containsVariant(
      productId: product.id,
      size: defaultSize,
      color: '',
    );

    // --------------------------------------------------
    // Toggle Wishlist
    // --------------------------------------------------

    Future<void> toggleWishlist() async {
      if (!wishlistProvider.hasCustomer) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to use your wishlist.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      if (isWishlisted) {
        final existing = wishlistProvider.items.firstWhere(
          (item) =>
              item.productId == product.id &&
              item.size == defaultSize &&
              item.color == '',
        );

        final success = await context.read<WishlistProvider>().removeItem(
          existing.id,
        );

        if (!context.mounted) return;

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} removed from wishlist'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      final success = await context.read<WishlistProvider>().addItem(
        WishlistItem(
          id: '',
          productId: product.id,
          name: product.name,
          category: product.brand,
          imageUrl: imageUrl,
          size: defaultSize,
          color: '',
          quantity: 1,
          price: displayPrice,
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? '${product.name} added to wishlist'
                : wishlistProvider.error ?? 'Failed to add to wishlist',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================================================
          // PRODUCT IMAGE
          // ==================================================
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.go(
                          '${AppRouter.shopProductDetails}/${product.id}',
                        );
                      },
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                ),

                // ==================================================
                // WISHLIST
                // ==================================================
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .55),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? Colors.red : Colors.white,
                      ),
                      onPressed: toggleWishlist,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // PRODUCT INFORMATION
          // ==================================================
          InkWell(
            onTap: openProductDetails,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --------------------------------------------------
                  // BRAND
                  // --------------------------------------------------
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading3,
                  ),

                  const SizedBox(height: 4),

                  // --------------------------------------------------
                  // PRODUCT NAME
                  // --------------------------------------------------
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium,
                  ),

                  const SizedBox(height: 8),

                  // --------------------------------------------------
                  // RATING + PRICE
                  // --------------------------------------------------
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),

                      const SizedBox(width: 4),

                      Text(
                        product.rating.toStringAsFixed(1),
                        style: AppTextStyles.bodyMedium,
                      ),

                      const Spacer(),

                      Text(
                        '₹${displayPrice.toStringAsFixed(0)}',
                        style: AppTextStyles.heading3.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // --------------------------------------------------
                  // OLD PRICE
                  // --------------------------------------------------
                  if (product.salePrice > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                  // --------------------------------------------------
                  // AVAILABLE SIZES
                  // --------------------------------------------------
                  if (availableSizes.isNotEmpty) ...[
                    const SizedBox(height: 14),

                    const Text(
                      'Available Sizes',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: availableSizes.map((size) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            size,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // ==================================================
                  // ACTION BUTTONS
                  // ==================================================
                  Row(
                    children: [
                      // ------------------------------------------------
                      // ADD TO CART
                      // ------------------------------------------------
                      Expanded(
                        child: ElevatedButton(
                          onPressed: product.stock > 0
                              ? () {
                                  // Product details page handles
                                  // size selection before cart.
                                  openProductDetails();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            product.stock > 0 ? 'Add to Cart' : 'Out of Stock',
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // ------------------------------------------------
                      // BUY NOW
                      // ------------------------------------------------
                      Expanded(
                        child: OutlinedButton(
                          onPressed: product.stock > 0
                              ? () {
                                  // Product details page handles
                                  // size selection before checkout.
                                  openProductDetails();
                                }
                              : null,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
