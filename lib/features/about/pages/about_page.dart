import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/about_hero/about_hero.dart';
import '../widgets/company_story/company_story.dart';
import '../widgets/journey/journey.dart';
import '../widgets/mission_vision/mission_vision.dart';
import '../widgets/values/values.dart';
import '../widgets/call_to_action/call_to_action.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.about,
      child: const Column(
        children: [

          AboutHero(),

          CompanyStory(),

          Journey(),

          MissionVision(),

          Values(),

          CallToAction(),

        ],
      ),
    );
  }
}