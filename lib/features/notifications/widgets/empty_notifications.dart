import 'package:flutter/material.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [

          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey,
          ),

          SizedBox(height: 20),

          Text(
            "No Notifications Yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 15),

          Text(
            "You'll receive updates about\n\n"
            "• Orders\n"
            "• New Products\n"
            "• Offers\n"
            "• Wishlist\n"
            "• Account",
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }
}