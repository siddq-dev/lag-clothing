import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/size_chart.dart';
import '../widgets/measurement_guide.dart';
import '../widgets/fit_information.dart';
import '../widgets/size_selector.dart';

class SizeGuidePage extends StatelessWidget {
  const SizeGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jersey Size Guide",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Find your perfect jersey size before placing your order.",
            ),

            const SizedBox(height: 40),

            const SizeSelector(),

            const SizedBox(height: 40),

            const SizeChart(),

            const SizedBox(height: 40),

            const MeasurementGuide(),

            const SizedBox(height: 40),

            const FitInformation(),
          ],
        ),
      ),
    );
  }
}
