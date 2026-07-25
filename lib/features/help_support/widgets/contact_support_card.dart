import 'package:flutter/material.dart';

import 'support_option_tile.dart';

class ContactSupportCard extends StatelessWidget {
  const ContactSupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact Support",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SupportOptionTile(
          icon: Icons.email_outlined,
          title: "Email Support",
          subtitle: "support@lagclothing.com",
          onTap: () {},
        ),

        SupportOptionTile(
          icon: Icons.phone_outlined,
          title: "Call Support",
          subtitle: "+91 98765 43210",
          onTap: () {},
        ),

        SupportOptionTile(
          icon: Icons.chat_outlined,
          title: "Live Chat",
          subtitle: "Available Soon",
          onTap: () {},
        ),

        SupportOptionTile(
          icon: Icons.message_outlined,
          title: "WhatsApp Support",
          subtitle: "+91 98765 43210",
          onTap: () {},
        ),
      ],
    );
  }
}
