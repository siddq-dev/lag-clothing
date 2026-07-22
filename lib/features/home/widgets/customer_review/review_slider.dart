import 'dart:async';

import 'package:flutter/material.dart';

import 'review_data.dart';
import 'review_item.dart';

class ReviewSlider extends StatefulWidget {
  const ReviewSlider({super.key});

  @override
  State<ReviewSlider> createState() => _ReviewSliderState();
}

class _ReviewSliderState extends State<ReviewSlider> {

  final PageController controller = PageController();

  int currentPage = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {

        currentPage++;

        if (currentPage >= reviews.length) {
          currentPage = 0;
        }

        controller.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 450,

      child: PageView.builder(

        controller: controller,

        itemCount: reviews.length,

        itemBuilder: (context,index){

          return ReviewItem(
            review: reviews[index],
          );

        },
      ),
    );
  }
}