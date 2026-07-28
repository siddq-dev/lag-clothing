import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../../../providers/notification_provider.dart';
import '../../../models/notification_settings_model.dart';

import '../widgets/notification_tile.dart';
import '../widgets/save_notification_button.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState
    extends State<NotificationsPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<NotificationProvider>()
          .loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<NotificationProvider>();

    if (provider.isLoading &&
        provider.settings == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    NotificationSettingsModel settings =
        provider.settings ??
            const NotificationSettingsModel(
              orderUpdates: true,
              promotions: true,
              newArrivals: true,
              backInStock: true,
              pushNotifications: true,
              emailNotifications: true,
              smsNotifications: false,
            );

    return WebsiteLayout(
      currentRoute: AppRouter.notifications,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Manage how you receive notifications from LAG Clothing.",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 35),

                  NotificationTile(
                    title: "Order Updates",
                    subtitle:
                        "Receive updates about your orders.",
                    icon: Icons.local_shipping,
                    value: settings.orderUpdates,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        orderUpdates: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  NotificationTile(
                    title: "Promotions",
                    subtitle:
                        "Receive offers and discounts.",
                    icon: Icons.local_offer,
                    value: settings.promotions,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        promotions: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  NotificationTile(
                    title: "New Arrivals",
                    subtitle:
                        "Get notified about new collections.",
                    icon: Icons.new_releases,
                    value: settings.newArrivals,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        newArrivals: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  NotificationTile(
                    title: "Back In Stock",
                    subtitle:
                        "Receive stock availability alerts.",
                    icon: Icons.inventory_2,
                    value: settings.backInStock,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        backInStock: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  NotificationTile(
                    title: "Push Notifications",
                    subtitle:
                        "Allow push notifications.",
                    icon: Icons.notifications,
                    value: settings.pushNotifications,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        pushNotifications: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  NotificationTile(
                    title: "Email Notifications",
                    subtitle:
                        "Receive updates via email.",
                    icon: Icons.email_outlined,
                    value:
                        settings.emailNotifications,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        emailNotifications: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  NotificationTile(
                    title: "SMS Notifications",
                    subtitle:
                        "Receive updates through SMS.",
                    icon: Icons.sms_outlined,
                    value:
                        settings.smsNotifications,
                    onChanged: (value) {
                      settings = settings.copyWith(
                        smsNotifications: value,
                      );
                      provider.updateSettings(
                          settings);
                    },
                  ),

                  const SizedBox(height: 35),

                  SaveNotificationButton(
                    provider: provider,
                    settings: settings,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}