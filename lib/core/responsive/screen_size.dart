import 'package:flutter/material.dart';

import 'breakpoints.dart';

class ScreenSize {
  ScreenSize._();

  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static bool isSmallMobile(BuildContext context) {
    return width(context) < Breakpoints.smallMobile;
  }

  static bool isMobile(BuildContext context) {
    return width(context) < Breakpoints.mobile;
  }

  static bool isTablet(BuildContext context) {
    final screenWidth = width(context);

    return screenWidth >= Breakpoints.mobile &&
        screenWidth < Breakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return width(context) >= Breakpoints.tablet;
  }
}
