import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/contact_hero/contact_hero.dart';
import '../widgets/contact_info.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.contact,
      child: const Column(
        children: [

          ContactHero(),
          ContactInfo(),

        ],
      ),
    );
  }
}