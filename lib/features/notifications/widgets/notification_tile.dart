import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.unread = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String time;
  final bool unread;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(

        leading: CircleAvatar(
          child: Icon(icon),
        ),

        title: Row(
          children: [

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (unread)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),

          ],
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(message),
        ),

        trailing: Text(
          time,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),

      ),
    );
  }
}