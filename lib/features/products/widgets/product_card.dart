import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/product_model.dart';

import '../../../routes/app_routes.dart';

import 'product_price.dart';
import 'product_rating.dart';
import 'wishlist_button.dart';
import 'add_to_cart_button.dart';
import 'buy_now_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final image = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : '';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        context.go(
          AppRouter.product,
          extra: product,
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 6,
              child: Stack(
                children: [

                  Positioned.fill(
                    child: image.isEmpty
                        ? Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image,
                              size: 60,
                            ),
                          )
                        : Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: WishlistButton(
                      product: product,
                    ),
                  ),

                  if (product.newArrival)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    product.brand,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  ProductRating(
                    rating:
                        product.rating,
                  ),

                  const SizedBox(height: 10),

                  ProductPrice(
                    price: product.price,
                    salePrice:
                        product.salePrice,
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [

                      Expanded(
                        child:
                            AddToCartButton(
                          product:
                              product,
                          quantity: 1,
                          selectedSize: '',
                          selectedColor: '',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: BuyNowButton(
                          product: product,
                          quantity: 1,
                          selectedSize: '',
                          selectedColor: '',
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}