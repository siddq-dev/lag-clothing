import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/delivery_timeline.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: const DeliveryTimeline(),
      ),
    );
  }
}
