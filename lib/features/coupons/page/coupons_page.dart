import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/coupon_header.dart';
import '../widgets/apply_coupon.dart';
import '../widgets/coupon_card.dart';
import '../widgets/coupon_terms.dart';
import '../widgets/empty_coupon.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {

    /// Temporary Data
    /// Replace with Firebase later

    final List<Map<String, dynamic>> coupons = [

      {
        "title": "20% OFF",
        "code": "LAG20",
        "description": "Applicable on all football jerseys.",
        "minimum": "\$50",
        "expiry": "31 Dec 2026",
      },

      {
        "title": "FREE SHIPPING",
        "code": "SHIPFREE",
        "description": "Free shipping on orders above \$80.",
        "minimum": "\$80",
        "expiry": "15 Aug 2026",
      },

    ];

    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const CouponHeader(),

            const SizedBox(height: AppSpacing.xxxl),

            const ApplyCoupon(),

            const SizedBox(height: AppSpacing.xxxl),

            if (coupons.isEmpty)

              const EmptyCoupon()

            else

              ListView.separated(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: coupons.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 18),
                itemBuilder: (context, index) {

                  final coupon = coupons[index];

                  return CouponCard(
                    title: coupon["title"],
                    code: coupon["code"],
                    description:
                        coupon["description"],
                    minimum:
                        coupon["minimum"],
                    expiry:
                        coupon["expiry"],
                  );
                },
              ),

            const SizedBox(height: AppSpacing.xxxl),

            const CouponTerms(),

          ],
        ),
      ),
    );
  }
}