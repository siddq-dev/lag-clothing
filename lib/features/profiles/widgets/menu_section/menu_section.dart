import 'package:flutter/material.dart';

import '../profile_tile/profile_tile.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ProfileTile(
          icon: Icons.person_outline,
          title: "Personal Information",
          subtitle: "Edit your profile details",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.shopping_bag_outlined,
          title: "My Orders",
          subtitle: "Track your purchases",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.favorite_border,
          title: "Wishlist",
          subtitle: "View your saved jerseys",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.location_on_outlined,
          title: "Saved Addresses",
          subtitle: "Manage shipping addresses",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.credit_card_outlined,
          title: "Payment Methods",
          subtitle: "Saved cards and UPI",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.settings_outlined,
          title: "Account Settings",
          subtitle: "Privacy and security",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.notifications_none_outlined,
          title: "Notifications",
          subtitle: "Manage notification preferences",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.help_outline,
          title: "Help & Support",
          subtitle: "Need assistance?",
          onTap: () {},
        ),

        ProfileTile(
          icon: Icons.info_outline,
          title: "About LAG Clothing",
          subtitle: "Version & company information",
          onTap: () {},
        ),

      ],
    );
  }
}