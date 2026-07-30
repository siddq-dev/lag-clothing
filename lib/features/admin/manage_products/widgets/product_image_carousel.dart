import 'package:flutter/material.dart';

import '../../../../../models/product_image_model.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
  });

  final List<ProductImageModel> images;

  @override
  State<ProductImageCarousel> createState() =>
      _ProductImageCarouselState();
}

class _ProductImageCarouselState
    extends State<ProductImageCarousel> {
  final PageController _controller =
      PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 420,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(
            Icons.image,
            size: 80,
          ),
        ),
      );
    }

    return Column(
      children: [

        SizedBox(
          height: 450,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(20),
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  widget.images[index].imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) {
              return AnimatedContainer(
                duration: const Duration(
                  milliseconds: 250,
                ),
                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                width:
                    currentIndex == index
                        ? 20
                        : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      currentIndex == index
                          ? Colors.blue
                          : Colors.grey,
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 25),

        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection:
                Axis.horizontal,
            itemCount:
                widget.images.length,
            itemBuilder:
                (context, index) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(
                    index,
                    duration:
                        const Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(
                    right: 10,
                  ),
                  decoration:
                      BoxDecoration(
                    border: Border.all(
                      color:
                          currentIndex ==
                                  index
                              ? Colors.blue
                              : Colors.grey,
                      width: 2,
                    ),
                    borderRadius:
                        BorderRadius
                            .circular(
                      10,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius
                            .circular(
                      8,
                    ),
                    child: Image.network(
                      widget
                          .images[index]
                          .imageUrl,
                      width: 90,
                      height: 90,
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