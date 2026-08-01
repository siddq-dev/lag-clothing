import 'package:flutter/material.dart';

import '/services/analytics_service.dart';

class AnalyticsRouteObserver extends NavigatorObserver {
  Future<void> _track(Route<dynamic>? route) async {
    if (route == null) return;

    final name = route.settings.name;

    if (name == null || name.isEmpty) return;

    await AnalyticsService.track(name);
  }

  @override
  void didPush(
    Route route,
    Route? previousRoute,
  ) {
    super.didPush(route, previousRoute);

    _track(route);
  }

  @override
  void didReplace({
    Route? newRoute,
    Route? oldRoute,
  }) {
    super.didReplace(
      newRoute: newRoute,
      oldRoute: oldRoute,
    );

    _track(newRoute);
  }

  @override
  void didPop(
    Route route,
    Route? previousRoute,
  ) {
    super.didPop(route, previousRoute);

    _track(previousRoute);
  }
}