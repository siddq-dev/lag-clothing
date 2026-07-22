import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: _buildItem(
              Icons.location_on_outlined,
              'Address',
              'LAG Clothing\nChennai,\nTamil Nadu, India',
            ),
          ),

          Expanded(
            child: _buildItem(
              Icons.phone_outlined,
              'Phone',
              '+91 98765 43210',
            ),
          ),

          Expanded(
            child: _buildItem(
              Icons.email_outlined,
              'Email',
              'support@lagclothing.com',
            ),
          ),

          Expanded(
            child: _buildItem(
              Icons.schedule_outlined,
              'Business Hours',
              'Mon - Sat\n9:00 AM - 8:00 PM',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Icon(
          icon,
          size: 40,
          color: AppColors.primary,
        ),

        const SizedBox(height: 20),

        Text(
          title,
          style: AppTextStyles.heading3,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          value,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}