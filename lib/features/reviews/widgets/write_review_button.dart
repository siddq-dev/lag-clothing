import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import 'review_form.dart';
import '../page/reviews_page.dart';

class WriteReviewButton extends StatelessWidget {
  const WriteReviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const _WriteReviewDialog();
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.rate_review_outlined),
        label: const Text(
          "WRITE A REVIEW",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _WriteReviewDialog extends StatelessWidget {
  const _WriteReviewDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: ReviewForm(),
        ),
      ),
    );
  }
}