import 'package:flutter/material.dart';


/// Standard spacing values used across the application.
class AppSpacing {
  AppSpacing._();

 // Base spacing values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;


   // Common page padding
  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(horizontal: xl, vertical: lg);

  // Section spacing
  static const SizedBox sectionGap = SizedBox(height: xxl);

  // Small spacing
  static const SizedBox smallGap = SizedBox(height: sm);

  // Medium spacing
  static const SizedBox mediumGap = SizedBox(height: md);

  // Large spacing
  static const SizedBox largeGap = SizedBox(height: lg);
}
