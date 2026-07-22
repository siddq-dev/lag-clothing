import 'package:flutter/material.dart';
import 'package:lag_clothing/core/constants/section_sizes.dart';

class NewArrivals extends StatelessWidget {
  const NewArrivals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SectionSizes.newArrivalsHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'New Arrivals',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}