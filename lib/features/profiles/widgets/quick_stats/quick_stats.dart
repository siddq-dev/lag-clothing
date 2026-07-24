import 'package:flutter/material.dart';

import '../stat_card/stat_card.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [

        StatCard(
          title: "Orders",
          count: "12",
          icon: Icons.shopping_bag_outlined,
        ),

        StatCard(
          title: "Wishlist",
          count: "08",
          icon: Icons.favorite_border,
        ),

        StatCard(
          title: "Addresses",
          count: "02",
          icon: Icons.location_on_outlined,
        ),

        StatCard(
          title: "Coupons",
          count: "04",
          icon: Icons.local_offer_outlined,
        ),

      ],
    );
  }
}