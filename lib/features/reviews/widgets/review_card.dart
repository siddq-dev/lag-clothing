import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.customerName,
    required this.rating,
    required this.reviewDate,
    required this.reviewText,
  });

  final String customerName;
  final int rating;
  final String reviewDate;
  final String reviewText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Customer Info
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    customerName[0].toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        reviewDate,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// Rating Stars
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 22,
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// Review Text
            Text(reviewText, style: const TextStyle(fontSize: 15, height: 1.6)),

            const SizedBox(height: 20),

            /// Helpful Section
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Firebase later
                  },
                  icon: const Icon(Icons.thumb_up_alt_outlined, size: 18),
                  label: const Text("Helpful"),
                ),

                const SizedBox(width: 10),

                TextButton.icon(
                  onPressed: () {
                    // Firebase later
                  },
                  icon: const Icon(Icons.flag_outlined, size: 18),
                  label: const Text("Report"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
