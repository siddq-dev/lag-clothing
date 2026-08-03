import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductGallery extends StatefulWidget {
  final ProductModel product;

  const ProductGallery({
    super.key,
    required this.product,
  });

  @override
  State<ProductGallery> createState() =>
      _ProductGalleryState();
}

class _ProductGalleryState
    extends State<ProductGallery> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    if (images.isEmpty) {
      return Card(
        child: SizedBox(
          height: 320,
          child: Center(
            child: Icon(
              Icons.image_not_supported,
              size: 90,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(12),
                child: Image.network(
                  images[selectedImage].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImage = index;
                      });
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              selectedImage == index
                                  ? Colors.red
                                  : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Image.network(
                        images[index].imageUrl,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}