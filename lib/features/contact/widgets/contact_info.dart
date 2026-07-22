import 'package:flutter/material.dart';

import 'contact_info_card.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.1,
        children: const [

          ContactInfoCard(
            icon: Icons.location_on_outlined,
            title: 'Address',
            subtitle:
                'LAG Clothing\nChennai, Tamil Nadu\nIndia',
          ),

          ContactInfoCard(
            icon: Icons.phone_outlined,
            title: 'Phone',
            subtitle:
                '+91 98765 43210',
          ),

          ContactInfoCard(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle:
                'support@lagclothing.com',
          ),

          ContactInfoCard(
            icon: Icons.schedule_outlined,
            title: 'Business Hours',
            subtitle:
                'Mon - Sat\n9:00 AM - 8:00 PM',
          ),
        ],
      ),
    );
  }
}