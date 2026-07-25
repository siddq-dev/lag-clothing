import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/empty_notifications.dart';
import '../widgets/notifications_filter.dart';
import '../widgets/notification_header.dart';
import '../widgets/notification_tile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int selectedFilter = 0;

  final List<Map<String, dynamic>> notifications = [
    {
      "icon": Icons.local_shipping,
      "title": "Order Shipped",
      "message": "Your order #1023 has been shipped.",
      "time": "2 hrs ago",
      "unread": true,
      "type": "Orders",
    },
    {
      "icon": Icons.new_releases,
      "title": "New Arrival",
      "message": "Manchester United 2026 Home Jersey is now available.",
      "time": "Today",
      "unread": true,
      "type": "Products",
    },
    {
      "icon": Icons.local_offer,
      "title": "Weekend Sale",
      "message": "Flat 20% OFF on all Jerseys.",
      "time": "Yesterday",
      "unread": false,
      "type": "Offers",
    },
    {
      "icon": Icons.favorite,
      "title": "Wishlist Update",
      "message": "One of your wishlist items is back in stock.",
      "time": "Yesterday",
      "unread": false,
      "type": "Wishlist",
    },
    {
      "icon": Icons.person,
      "title": "Profile Updated",
      "message": "Your profile information has been updated successfully.",
      "time": "3 days ago",
      "unread": false,
      "type": "Account",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotifications;

    if (selectedFilter == 0) {
      filteredNotifications = notifications;
    } else {
      final filter = NotificationFilter.filters[selectedFilter];

      filteredNotifications = notifications
          .where((item) => item["type"] == filter)
          .toList();
    }

    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NotificationHeader(),

            const SizedBox(height: AppSpacing.xxl),

            NotificationFilter(
              selectedIndex: selectedFilter,
              onChanged: (index) {
                setState(() {
                  selectedFilter = index;
                });
              },
            ),

            const SizedBox(height: AppSpacing.xxl),

            if (filteredNotifications.isEmpty)
              const EmptyNotifications()
            else
              Column(
                children: List.generate(
                  filteredNotifications.length,
                  (index) {
                    final notification = filteredNotifications[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: NotificationTile(
                        icon: notification["icon"],
                        title: notification["title"],
                        message: notification["message"],
                        time: notification["time"],
                        unread: notification["unread"],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}