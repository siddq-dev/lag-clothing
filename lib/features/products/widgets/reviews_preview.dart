import 'package:flutter/material.dart';

class ReviewsPreview extends StatelessWidget {
  const ReviewsPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Customer Reviews",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),

              title: const Text(
                "John Doe",
              ),

              subtitle: const Text(
                "Excellent quality jersey. Worth the price.",
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  Icon(Icons.star,
                      color: Colors.amber,
                      size: 18),

                  Icon(Icons.star,
                      color: Colors.amber,
                      size: 18),

                  Icon(Icons.star,
                      color: Colors.amber,
                      size: 18),

                  Icon(Icons.star,
                      color: Colors.amber,
                      size: 18),

                  Icon(Icons.star,
                      color: Colors.amber,
                      size: 18),
                ],
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {},
              child: const Text(
                "View All Reviews",
              ),
            ),

          ],
        ),
      ),
    );
  }
}