import 'package:flutter/material.dart';

class FitInformation extends StatelessWidget {
  const FitInformation({super.key});

  Widget buildInfoTile(
    IconData icon,
    String title,
    String description,
  ) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          description,
          style: const TextStyle(
            height: 1.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                "Fit Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            buildInfoTile(
              Icons.check_circle_outline,
              "Regular Fit",
              "Designed for everyday comfort with a relaxed fit suitable for most body types.",
            ),

            buildInfoTile(
              Icons.sports_soccer,
              "Match Fit",
              "Slim athletic fit similar to what professional players wear on the field.",
            ),

            buildInfoTile(
              Icons.info_outline,
              "Recommendation",
              "If you're between two sizes, choose the larger size for a more comfortable fit.",
            ),

            buildInfoTile(
              Icons.local_shipping_outlined,
              "Easy Exchange",
              "Wrong size? Size exchanges are available within the return policy period.",
            ),

          ],
        ),
      ),
    );
  }
}