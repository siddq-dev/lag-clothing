import 'package:flutter/material.dart';

import '../../../../themes/app_text_style.dart';
import 'social_button.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Column(
        children: [

          const Text(
            'Follow LAG Clothing',
            style: AppTextStyles.sectionTitle,
          ),

          const SizedBox(height: 16),

          const Text(
            'Stay connected for the latest jersey drops and exclusive collections.',
            style: AppTextStyles.sectionSubtitle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [

              SocialButton(
                icon: Icons.camera_alt_outlined,
                label: 'Instagram',
                onTap: () {},
              ),

              SocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                onTap: () {},
              ),

              SocialButton(
                icon: Icons.play_circle_outline,
                label: 'YouTube',
                onTap: () {},
              ),

              SocialButton(
                icon: Icons.alternate_email,
                label: 'X',
                onTap: () {},
              ),

              SocialButton(
                icon: Icons.chat,
                label: 'WhatsApp',
                onTap: () {},
              ),

            ],
          ),
        ],
      ),
    );
  }
}