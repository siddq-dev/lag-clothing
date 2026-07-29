import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';

import '../../../models/product_model.dart';
import '../widgets/reviews_preview.dart';

import '../widgets/product_image_gallery.dart';
import '../widgets/product_information.dart';
import '../widgets/product_description.dart';
import '../widgets/related_products.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: ModalRoute.of(context)?.settings.name ?? '',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 40,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ProductImageGallery(
                    product: product,
                  ),
                ),

                const SizedBox(width: 40),

                Expanded(
                  flex: 4,
                  child: ProductInformation(
                    product: product,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            ProductDescription(
              product: product,
            ),
            const SizedBox(height: 50),

ReviewsPreview(),



            const SizedBox(height: 80),

            RelatedProducts(
              currentProduct: product,
            ),
          ],
        ),
      ),
    );
  }
}