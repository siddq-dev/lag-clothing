import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../themes/app_colors.dart';
import 'product_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final ProductModel product;
  final VoidCallback onTap;

  String get primaryImage {
    final primary = product.images.where((image) => image.isPrimary);

    if (primary.isNotEmpty) {
      return primary.first.imageUrl;
    }

    if (product.images.isNotEmpty) {
      return product.images.first.imageUrl;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: ProductImage(image: primaryImage, isNew: false),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
