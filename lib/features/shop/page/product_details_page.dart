import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../layout/website_layout.dart';
import '../../../providers/product_details_provider.dart';
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

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(100),
              child: CircularProgressIndicator(),
            ),
          );
        }

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
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                  // ------------------------------------------------
                  // IMAGES
                  // ------------------------------------------------
                  Expanded(flex: 6, child: _ProductImages(product: product)),

                  const SizedBox(width: 60),

                  // ------------------------------------------------
                  // DETAILS
                  // ------------------------------------------------
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
              // PRODUCT INFORMATION
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
        // SIZES
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
              return ChoiceChip(
                label: Text(size),
                selected: provider.selectedSize == size,
                onSelected: (_) {
                  provider.selectSize(size);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),
        ],

        // ========================================================
        // COLORS
        // ========================================================
        if (provider.availableColors.isNotEmpty) ...[
          const Text(
            'Color',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            children: provider.availableColors.map((color) {
              return ChoiceChip(
                label: Text(color),
                selected: provider.selectedColor == color,
                onSelected: (_) {
                  provider.selectColor(color);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),
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
              onPressed: provider.increaseQuantity,
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
                onPressed: () {
                  final error = provider.validateSelection();

                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  // TODO:
                  // Add product + selected variant
                  // + quantity to cart.

                  context.go(AppRouter.cart);
                },
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
              onPressed: () {
                final error = provider.validateSelection();

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                // TODO:
                // Add product + selected variant
                // to wishlist.
              },
              icon: const Icon(Icons.favorite_border),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              final error = provider.validateSelection();

              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              context.go(AppRouter.checkout);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Buy Now'),
          ),
        ),
      ],
    );
  }
}

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
