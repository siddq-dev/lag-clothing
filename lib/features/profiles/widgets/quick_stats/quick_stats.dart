import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/customer_provider.dart';
import '../stat_card/stat_card.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();
    final customer = provider.customer;

    return Row(
      children: [
        StatCard(
          title: "Orders",
          count: "${customer?.orders.length ?? 0}",
          icon: Icons.shopping_bag_outlined,
        ),

        StatCard(
          title: "Wishlist",
          count: "${customer?.wishlist.length ?? 0}",
          icon: Icons.favorite_border,
        ),

        StatCard(
          title: "Addresses",
          count: "${customer?.addresses.length ?? 0}",
          icon: Icons.location_on_outlined,
        ),

        const StatCard(
          title: "Coupons",
          count: "0",
          icon: Icons.local_offer_outlined,
        ),
      ],
    );
  }
}