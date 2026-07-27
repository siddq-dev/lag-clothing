import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
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
          onTap: () {
            context.go(AppRouter.editProfile);
          },
        ),

        ProfileTile(
          icon: Icons.shopping_bag_outlined,
          title: "My Orders",
          subtitle: "Track your purchases",
          onTap: () {
            context.go(AppRouter.myOrders);
          },
        ),

        ProfileTile(
          icon: Icons.favorite_border,
          title: "Wishlist",
          subtitle: "View your saved jerseys",
          onTap: () {
            context.go(AppRouter.wishlist);
          },
        ),

        ProfileTile(
          icon: Icons.location_on_outlined,
          title: "Saved Addresses",
          subtitle: "Manage shipping addresses",
          onTap: () {
            context.go(AppRouter.savedAddresses);
          },
        ),

        ProfileTile(
          icon: Icons.credit_card_outlined,
          title: "Payment Methods",
          subtitle: "Saved cards and UPI",
          onTap: () {
            context.go(AppRouter.paymentMethods);
          },
        ),

        ProfileTile(
          icon: Icons.settings_outlined,
          title: "Account Settings",
          subtitle: "Privacy and security",
          onTap: () {
            context.go(AppRouter.accountSettings);
          },
        ),

        ProfileTile(
          icon: Icons.notifications_none_outlined,
          title: "Notifications",
          subtitle: "Manage notification preferences",
          onTap: () {
            context.go(AppRouter.notifications);
          },
        ),

        ProfileTile(
          icon: Icons.help_outline,
          title: "Help & Support",
          subtitle: "Need assistance?",
          onTap: () {
            context.go(AppRouter.helpSupport);
          },
        ),

        ProfileTile(
          icon: Icons.info_outline,
          title: "About LAG Clothing",
          subtitle: "Version & company information",
          onTap: () {
            context.go(AppRouter.about);
          },
        ),
      ],
    );
  }
}