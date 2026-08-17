import 'package:flutter/material.dart';

class CouponTerms extends StatelessWidget {
  const CouponTerms({super.key});

  Widget buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 18),

          const SizedBox(width: 10),

          Expanded(child: Text(text, style: const TextStyle(height: 1.5))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Coupon Terms & Conditions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            buildItem("Only one coupon can be used per order."),

            buildItem(
              "Coupons cannot be combined with other promotional offers.",
            ),

            buildItem("Coupons are valid only before their expiry date."),

            buildItem("Minimum order value must be satisfied."),

            buildItem(
              "LAG Clothing reserves the right to cancel invalid coupon usage.",
            ),
          ],
        ),
      ),
    );
  }
}
