import 'package:flutter/material.dart';

class SocialSupportLinks extends StatelessWidget {
  const SocialSupportLinks({super.key});

  Widget socialButton(IconData icon, String title) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Connect With Us",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            socialButton(Icons.camera_alt_outlined, "Instagram"),

            socialButton(Icons.facebook, "Facebook"),

            socialButton(Icons.play_circle_outline, "YouTube"),

            socialButton(Icons.alternate_email, "X"),
          ],
        ),

        const SizedBox(height: 30),

        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Support Hours",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),

                Text("Monday - Saturday"),

                Text("09:00 AM - 07:00 PM"),

                SizedBox(height: 15),

                Text(
                  "Average Response Time",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8),

                Text("Within 24 Hours"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
