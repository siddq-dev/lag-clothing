import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/review_header.dart';
import '../widgets/rating_summary.dart';
import '../widgets/review_card.dart';
import '../widgets/write_review_button.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Temporary Data
    /// Replace with Firebase later

    final List<Map<String, dynamic>> reviews = [
      {
        "name": "John Smith",
        "rating": 5,
        "date": "20 Jul 2026",
        "review":
            "Excellent quality jersey. Fabric feels premium and delivery was fast.",
      },
      {
        "name": "David Miller",
        "rating": 4,
        "date": "18 Jul 2026",
        "review":
            "Good fitting jersey. Printing quality is very nice.",
      },
      {
        "name": "Alex Johnson",
        "rating": 5,
        "date": "14 Jul 2026",
        "review":
            "Absolutely loved it. Will definitely buy again.",
      },
    ];

    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const ReviewHeader(),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            const RatingSummary(),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            const WriteReviewButton(),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final review = reviews[index];

                return ReviewCard(
                  customerName: review["name"],
                  rating: review["rating"],
                  reviewDate: review["date"],
                  reviewText: review["review"],
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}