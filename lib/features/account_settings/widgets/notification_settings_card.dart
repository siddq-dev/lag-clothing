import 'package:flutter/material.dart';

class NotificationSettingsCard extends StatefulWidget {
  const NotificationSettingsCard({super.key});

  @override
  State<NotificationSettingsCard> createState() =>
      _NotificationSettingsCardState();
}

class _NotificationSettingsCardState extends State<NotificationSettingsCard> {
  bool orders = true;
  bool offers = true;
  bool products = true;
  bool wishlist = true;
  bool email = true;
  bool sms = false;

  Widget buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              "Notification Preferences",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),

          buildSwitch(
            "Order Updates",
            orders,
            (v) => setState(() => orders = v),
          ),
          buildSwitch(
            "Promotional Offers",
            offers,
            (v) => setState(() => offers = v),
          ),
          buildSwitch(
            "New Product Alerts",
            products,
            (v) => setState(() => products = v),
          ),
          buildSwitch(
            "Wishlist Alerts",
            wishlist,
            (v) => setState(() => wishlist = v),
          ),
          buildSwitch(
            "Email Notifications",
            email,
            (v) => setState(() => email = v),
          ),
          buildSwitch("SMS Notifications", sms, (v) => setState(() => sms = v)),
        ],
      ),
    );
  }
}
