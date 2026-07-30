import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

import '../widgets/product_image_carousel.dart';
import '../widgets/product_information_card.dart';
import '../widgets/product_variant_preview.dart';
import '../widgets/product_seo_preview.dart';
import '../widgets/product_action_buttons.dart';

class ProductPreviewPage extends StatelessWidget {
  const ProductPreviewPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Preview"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ProductImageCarousel(
                  images: product.images,
                ),

                const SizedBox(height: 30),

                ProductInformationCard(
                  product: product,
                ),

                const SizedBox(height: 30),

                ProductVariantPreview(
                  variants: product.variants,
                ),

                const SizedBox(height: 30),

                ProductSeoPreview(
                  seo: product.seo,
                ),

                const SizedBox(height: 40),

                ProductActionButtons(
                  product: product,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}