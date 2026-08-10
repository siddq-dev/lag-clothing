import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductGallery extends StatefulWidget {
  final ProductModel product;

  const ProductGallery({super.key, required this.product});

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    if (images.isEmpty) {
      return Card(
        child: SizedBox(
          height: 320,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported,
                  size: 90,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 12),
                const Text(
                  "No product images available",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Safety in case the selected index becomes invalid.
    if (selectedImage >= images.length) {
      selectedImage = 0;
    }

    final selectedProductImage = images[selectedImage];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  selectedProductImage.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.contain,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(child: CircularProgressIndicator());
                  },

                  errorBuilder: (context, error, stackTrace) {
                    debugPrint("=================================");
                    debugPrint("PRODUCT IMAGE FAILED");
                    debugPrint("URL: ${selectedProductImage.imageUrl}");
                    debugPrint("ERROR: $error");
                    debugPrint("STACK: $stackTrace");
                    debugPrint("=================================");

                    return Container(
                      color: const Color(0xFF1A1A1A),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 70,
                              color: Colors.red,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Unable to load image",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImage = index;
                      });
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedImage == index
                              ? Colors.red
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          image.imageUrl,
                          fit: BoxFit.cover,

                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            }

                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },

                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.red,
                              ),
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
        ),
      ),
    );
  }
}
