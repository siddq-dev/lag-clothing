import 'package:flutter/material.dart';

import 'screen_size.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.desktop,
    this.tablet,
    this.mobile,
  });

  final Widget desktop;
  final Widget? tablet;
  final Widget? mobile;

  @override
  Widget build(BuildContext context) {
    if (ScreenSize.isMobile(context)) {
      return mobile ?? desktop;
    }

    if (ScreenSize.isTablet(context)) {
      return tablet ?? desktop;
    }

    return desktop;
  }
}