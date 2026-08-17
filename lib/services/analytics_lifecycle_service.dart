import 'package:flutter/widgets.dart';

import 'analytics_service.dart';

class AnalyticsLifecycleService extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      AnalyticsService.endSession();
    }
  }
}
