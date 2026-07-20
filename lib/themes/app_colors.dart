import 'package:flutter/material.dart';

/// Centralized color palette for the entire application.
/// Never use Color(0xFF...) directly inside widgets.
class AppColors {
  AppColors._();

  // ===========================
  // Brand Colors
  // ===========================

  static const Color primary = Color(0xFFE10600);
  static const Color primaryHover = Color(0xFFFF2A1F);

  // ===========================
  // Background Colors
  // ===========================

  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF181818);

  // ===========================
  // Text Colors
  // ===========================

  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB3B3B3);

  // ===========================
  // Border & Divider
  // ===========================

  static const Color border = Color(0xFF2A2A2A);
  static const Color divider = Color(0xFF242424);

  // ===========================
  // Status Colors
  // ===========================

  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);

  // ===========================
  // Utility Colors
  // ===========================

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}