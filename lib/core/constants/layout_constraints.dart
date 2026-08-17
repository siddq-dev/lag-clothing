import 'package:flutter/material.dart';

class LayoutConstraints {
  LayoutConstraints._();

  /// Maximum width for website content.
  static const BoxConstraints website = BoxConstraints(maxWidth: 1400);

  /// Maximum width for text-heavy content.
  static const BoxConstraints text = BoxConstraints(maxWidth: 550);

  /// Maximum width for forms.
  static const BoxConstraints form = BoxConstraints(maxWidth: 450);

  /// Maximum width for product descriptions.
  static const BoxConstraints productDescription = BoxConstraints(
    maxWidth: 650,
  );

  /// Standard desktop page horizontal padding.
  static const double desktopHorizontalPadding = 64;

  /// Standard tablet page horizontal padding.
  static const double tabletHorizontalPadding = 32;

  /// Standard mobile page horizontal padding.
  static const double mobileHorizontalPadding = 12;
}
