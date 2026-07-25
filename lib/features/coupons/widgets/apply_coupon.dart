import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import 'apply_coupon_button.dart';

class ApplyCoupon extends StatefulWidget {
  const ApplyCoupon({super.key});

  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  final TextEditingController couponController =
      TextEditingController();

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  void applyCoupon() {
    final code = couponController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a coupon code.",
          ),
        ),
      );
      return;
    }

    // Firebase validation will be added later

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Coupon '$code' applied successfully!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Apply Coupon",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Enter your coupon code below to receive discounts on your purchase.",
            ),

            const SizedBox(height: 25),

            TextField(
              controller: couponController,
              decoration: InputDecoration(
                hintText: "Enter Coupon Code",
                prefixIcon: const Icon(
                  Icons.local_offer_outlined,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    couponController.clear();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ApplyCouponButton(
              onPressed: applyCoupon,
            ),

          ],
        ),
      ),
    );
  }
}