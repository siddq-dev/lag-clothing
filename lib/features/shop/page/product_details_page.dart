import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/wishlist_items.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/product_details_provider.dart';
import '../../../providers/wishlist_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../themes/app_colors.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ProductDetailsProvider(productId: productId)..loadProduct(),
      child: WebsiteLayout(
        currentRoute: AppRouter.shop,
        child: const _ProductDetailsContent(),
      ),
    );
  }
}

// ================================================================
// CONTENT
// ================================================================

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, _) {
        // ========================================================
        // LOADING
        // ========================================================

        if (provider.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(100),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // ========================================================
        // ERROR
        // ========================================================

        if (provider.error != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(provider.error!, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: provider.loadProduct,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // ========================================================
        // PRODUCT
        // ========================================================

        final product = provider.product;

        if (product == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(100),
              child: Text('Product not found'),
            ),
          );
        }

        final displayPrice = product.salePrice > 0
            ? product.salePrice
            : product.price;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // BREADCRUMB
              // ==================================================
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.go(AppRouter.shop);
                    },
                    child: const Text('Shop'),
                  ),
                  const Icon(Icons.chevron_right, size: 18),
                  Expanded(
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ==================================================
              // PRODUCT
              // ==================================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: _ProductImages(product: product)),

                  const SizedBox(width: 60),

                  Expanded(
                    flex: 5,
                    child: _ProductInformation(
                      provider: provider,
                      displayPrice: displayPrice,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              // ==================================================
              // DESCRIPTION
              // ==================================================
              _ProductDescription(description: product.description),

              const SizedBox(height: 50),

              // ==================================================
              // META
              // ==================================================
              _ProductMeta(
                category: product.category,
                subCategory: product.subCategory,
                brand: product.brand,
              ),

              const SizedBox(height: 50),

              // ==================================================
              // REVIEWS
              // ==================================================
              _ProductReviews(
                rating: product.rating,
                reviewCount: product.reviewCount,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ================================================================
// PRODUCT IMAGES
// ================================================================

class _ProductImages extends StatefulWidget {
  const _ProductImages({required this.product});

  final dynamic product;

  @override
  State<_ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<_ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    if (images.isEmpty) {
      return Container(
        height: 550,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Center(
          child: Icon(Icons.image_outlined, size: 80, color: Colors.grey),
        ),
      );
    }

    if (selectedImage >= images.length) {
      selectedImage = 0;
    }

    return Column(
      children: [
        Container(
          height: 550,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey.shade100,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              images[selectedImage].imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final selected = selectedImage == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = index;
                  });
                },
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.network(
                      images[index].imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ================================================================
// PRODUCT INFORMATION
// ================================================================

class _ProductInformation extends StatelessWidget {
  const _ProductInformation({
    required this.provider,
    required this.displayPrice,
  });

  final ProductDetailsProvider provider;
  final double displayPrice;

  @override
  Widget build(BuildContext context) {
    final product = provider.product!;
    final selectedVariant = provider.selectedVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.brand,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 10),

        Text(
          product.name,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 21),
            const SizedBox(width: 6),
            Text(
              product.rating.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            Text(
              '(${product.reviewCount} reviews)',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 25),

        // ========================================================
        // PRICE
        // ========================================================
        Row(
          children: [
            Text(
              '₹${displayPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            if (product.salePrice > 0) ...[
              const SizedBox(width: 12),
              Text(
                '₹${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 30),

        // ========================================================
        // SIZE
        // ========================================================
        if (provider.availableSizes.isNotEmpty) ...[
          const Text(
            'Size',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: provider.availableSizes.map((size) {
              final selected = provider.selectedSize == size;

              return ChoiceChip(
                label: Text(size),
                selected: selected,
                onSelected: (_) {
                  provider.selectSize(size);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),
        ],

        // ========================================================
        // COLOR
        // ========================================================
        if (provider.availableColors.isNotEmpty) ...[
          const Text(
            'Color',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: provider.availableColors.map((color) {
              final selected = provider.selectedColor == color;

              return ChoiceChip(
                label: Text(color),
                selected: selected,
                onSelected: (_) {
                  provider.selectColor(color);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),
        ],

        // ========================================================
        // EXACT VARIANT STOCK
        // ========================================================
        if (selectedVariant != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: selectedVariant.stock > 5
                  ? Colors.green.withOpacity(0.08)
                  : Colors.orange.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.inventory_2_outlined, size: 18),
                const SizedBox(width: 8),
                Text(
                  '${selectedVariant.stock} available',
                  style: TextStyle(
                    color: selectedVariant.stock > 5
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],

        // ========================================================
        // QUANTITY
        // ========================================================
        const Text(
          'Quantity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            IconButton(
              onPressed: provider.quantity > 1
                  ? provider.decreaseQuantity
                  : null,
              icon: const Icon(Icons.remove),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(provider.quantity.toString()),
            ),

            IconButton(
              onPressed:
                  selectedVariant != null &&
                      selectedVariant.stock > 0 &&
                      provider.quantity < selectedVariant.stock
                  ? provider.increaseQuantity
                  : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // ========================================================
        // ACTIONS
        // ========================================================
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () => _addToCart(context, provider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add to Cart'),
              ),
            ),

            const SizedBox(width: 12),

            IconButton(
              onPressed: () => _addToWishlist(context, provider),
              icon: const Icon(Icons.favorite_border),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _buyNow(context, provider),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Buy Now'),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  Future<void> _addToCart(
    BuildContext context,
    ProductDetailsProvider provider,
  ) async {
    // ----------------------------------------------------------
    // VALIDATE SELECTION
    // ----------------------------------------------------------

    final validation = provider.validateSelection();

    if (validation != null) {
      _showSnackBar(context, validation);
      return;
    }

    // ----------------------------------------------------------
    // PRODUCT
    // ----------------------------------------------------------

    final product = provider.product;

    if (product == null) {
      _showSnackBar(context, 'Product not found.');
      return;
    }

    // ----------------------------------------------------------
    // EXACT SELECTED VARIANT
    // ----------------------------------------------------------

    final variant = provider.selectedVariant;

    if (variant == null) {
      _showSnackBar(context, 'Please select a valid size and color.');
      return;
    }

    // ----------------------------------------------------------
    // FINAL STOCK CHECK
    // ----------------------------------------------------------

    if (!variant.available || variant.stock <= 0) {
      _showSnackBar(context, 'Selected size and color are out of stock.');
      return;
    }

    if (provider.quantity > variant.stock) {
      _showSnackBar(context, 'Only ${variant.stock} item(s) are available.');
      return;
    }

    // ----------------------------------------------------------
    // EXACT SELECTED VALUES
    // ----------------------------------------------------------

    final selectedSize = provider.selectedSize?.trim() ?? '';

    final selectedColor = provider.selectedColor?.trim() ?? '';

    if (selectedSize.isEmpty && provider.availableSizes.isNotEmpty) {
      _showSnackBar(context, 'Please select a size.');
      return;
    }

    if (selectedColor.isEmpty && provider.availableColors.isNotEmpty) {
      _showSnackBar(context, 'Please select a color.');
      return;
    }

    // ----------------------------------------------------------
    // CART ITEM
    //
    // ONLY:
    // product
    // selected size
    // selected color
    // selected quantity
    // ----------------------------------------------------------

    final cartItem = CartItemModel(
      id: '',
      productId: product.id,
      productName: product.name,
      productImage: product.images.isNotEmpty
          ? product.images.first.imageUrl
          : '',
      price: product.salePrice > 0 ? product.salePrice : product.price,
      quantity: provider.quantity,
      size: selectedSize,
      color: selectedColor,
      sku: variant.sku,
    );

    // ----------------------------------------------------------
    // ADD
    // ----------------------------------------------------------

    try {
      final cartProvider = context.read<CartProvider>();

      final success = await cartProvider.addItem(cartItem);

      if (!context.mounted) {
        return;
      }

      if (!success) {
        _showSnackBar(
          context,
          cartProvider.error ?? 'Failed to add product to cart.',
        );
        return;
      }

      // --------------------------------------------------------
      // SUCCESS
      // --------------------------------------------------------

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // --------------------------------------------------------
      // GO TO CART
      // --------------------------------------------------------

      context.go(AppRouter.cart);
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      _showSnackBar(context, e.toString());
    }
  }

  // ============================================================
  // BUY NOW
  // ============================================================

  Future<void> _buyNow(
    BuildContext context,
    ProductDetailsProvider provider,
  ) async {
    await _addToCart(context, provider);
  }

  // ============================================================
  // WISHLIST
  // ============================================================

  Future<void> _addToWishlist(
    BuildContext context,
    ProductDetailsProvider provider,
  ) async {
    final validation = provider.validateSelection();

    if (validation != null) {
      _showSnackBar(context, validation);
      return;
    }

    final product = provider.product;

    if (product == null) {
      _showSnackBar(context, 'Product not found.');
      return;
    }

    final size = provider.selectedSize?.trim() ?? '';

    final color = provider.selectedColor?.trim() ?? '';

    final wishlistItem = WishlistItem(
      id: '${product.id}|$size|$color',
      productId: product.id,
      name: product.name,
      category: product.category,
      imageUrl: product.images.isNotEmpty ? product.images.first.imageUrl : '',
      size: size,
      color: color,
      quantity: provider.quantity,
      price: product.salePrice > 0 ? product.salePrice : product.price,
    );

    final wishlistProvider = context.read<WishlistProvider>();

    final success = await wishlistProvider.addItem(wishlistItem);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Added to Wishlist'
              : wishlistProvider.error ?? 'Failed to add to wishlist',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (success) {
      context.go(AppRouter.wishlist);
    }
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}

// ================================================================
// DESCRIPTION
// ================================================================

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          description.isNotEmpty ? description : 'No description available.',
          style: const TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// PRODUCT META
// ================================================================

class _ProductMeta extends StatelessWidget {
  const _ProductMeta({
    required this.category,
    required this.subCategory,
    required this.brand,
  });

  final String category;
  final String subCategory;
  final String brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _MetaRow(label: 'Brand', value: brand),
        _MetaRow(label: 'Category', value: category),
        _MetaRow(label: 'Sub Category', value: subCategory),
      ],
    );
  }
}

// ================================================================
// META ROW
// ================================================================

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value.isNotEmpty ? value : '-')),
        ],
      ),
    );
  }
}

// ================================================================
// REVIEWS
// ================================================================

class _ProductReviews extends StatelessWidget {
  const _ProductReviews({required this.rating, required this.reviewCount});

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 15),
            const Icon(Icons.star, color: Colors.amber, size: 30),
            const SizedBox(width: 8),
            Text(
              '$reviewCount reviews',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
