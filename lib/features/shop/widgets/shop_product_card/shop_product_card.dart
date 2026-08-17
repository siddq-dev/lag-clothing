import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_model.dart';
import '../../../../models/wishlist_items.dart';
import '../../../../providers/wishlist_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';

class ShopProductCard extends StatelessWidget {
  const ShopProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : '';

    final wishlistProvider = context.watch<WishlistProvider>();

    // --------------------------------------------------
    // Available size
    // --------------------------------------------------

    final availableSizes = product.variants
        .where((variant) => variant.available)
        .map((variant) => variant.size.trim())
        .where((size) => size.isNotEmpty)
        .toSet()
        .toList();

    final defaultSize = availableSizes.isNotEmpty ? availableSizes.first : '';

    // --------------------------------------------------
    // Wishlist state
    // --------------------------------------------------

    final isWishlisted = wishlistProvider.containsVariant(
      productId: product.id,
      size: defaultSize,
      color: '',
    );

    // --------------------------------------------------
    // Open product details
    // --------------------------------------------------

    void openProductDetails() {
      context.go('${AppRouter.shopProductDetails}/${product.id}');
    }

    // --------------------------------------------------
    // Toggle wishlist
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

      // Remove
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

      // Add
      final displayPrice = product.salePrice > 0
          ? product.salePrice
          : product.price;

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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: openProductDetails,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // PRODUCT IMAGE
              // ==================================================
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
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
                                      size: 42,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 42,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                    ),

                    // ==================================================
                    // WISHLIST BUTTON
                    // ==================================================
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 38,
                            minHeight: 38,
                          ),
                          icon: Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 21,
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
              // PRODUCT NAME ONLY
              // ==================================================
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
