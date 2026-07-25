import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({super.key});

  Widget _buildRatingBar(
    int star,
    double value,
    int count,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          SizedBox(
            width: 25,
            child: Text(
              "$star",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Icon(
            Icons.star,
            size: 18,
            color: Colors.amber,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(
                  AppColors.primary,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: 40,
            child: Text(
              "$count",
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Left Side
            Expanded(
              flex: 2,
              child: Column(
                children: [

                  const Text(
                    "4.8",
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 26,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Based on 156 Reviews",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(width: 40),

            /// Right Side
            Expanded(
              flex: 3,
              child: Column(
                children: [

                  _buildRatingBar(
                    5,
                    0.82,
                    128,
                  ),

                  _buildRatingBar(
                    4,
                    0.13,
                    20,
                  ),

                  _buildRatingBar(
                    3,
                    0.03,
                    5,
                  ),

                  _buildRatingBar(
                    2,
                    0.01,
                    2,
                  ),

                  _buildRatingBar(
                    1,
                    0.01,
                    1,
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