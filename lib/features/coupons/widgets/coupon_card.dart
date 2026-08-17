import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.title,
    required this.code,
    required this.description,
    required this.minimum,
    required this.expiry,
  });

  final String title;
  final String code;
  final String description;
  final String minimum;
  final String expiry;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(description),

                  const SizedBox(height: 10),

                  Text("Minimum Order : $minimum"),

                  Text("Valid Until : $expiry"),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // Apply Later
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text("APPLY"),
            ),
          ],
        ),
      ),
    );
  }
}
