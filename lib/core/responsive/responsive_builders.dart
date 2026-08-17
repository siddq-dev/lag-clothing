import 'package:flutter/material.dart';

import 'screen_size.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.desktop,
    this.tablet,
    this.mobile,
    this.smallMobile,
  });

  final Widget desktop;
  final Widget? tablet;
  final Widget? mobile;
  final Widget? smallMobile;

  @override
  Widget build(BuildContext context) {
    if (ScreenSize.isSmallMobile(context)) {
      return smallMobile ?? mobile ?? tablet ?? desktop;
    }

    if (ScreenSize.isMobile(context)) {
      return mobile ?? tablet ?? desktop;
    }

    if (ScreenSize.isTablet(context)) {
      return tablet ?? desktop;
    }

    return desktop;
  }
}
