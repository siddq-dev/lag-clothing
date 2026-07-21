import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Centralized text styles used throughout the application.
class AppTextStyles {
  AppTextStyles._();

  // ===========================
  // Hero Section
  // ===========================

  static const TextStyle heroTitle = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -1,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  // ===========================
  // Section Titles
  // ===========================

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );


// ===========================
// Headings
// ===========================

static const TextStyle heading1 = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  color: AppColors.textPrimary,
);

static const TextStyle heading2 = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: AppColors.textPrimary,
);

static const TextStyle heading3 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: AppColors.textPrimary,
);

static const TextStyle heading4 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: AppColors.textPrimary,
);


  // ===========================
  // Card Text
  // ===========================

  static const TextStyle cardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ===========================
// Body Text
// ===========================

static const TextStyle bodyLarge = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: AppColors.textPrimary,
  height: 1.6,
);

static const TextStyle bodyMedium = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.textPrimary,
  height: 1.5,
);

static const TextStyle bodySmall = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColors.textSecondary,
  height: 1.5,
);

static const TextStyle caption = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: AppColors.textSecondary,
);

  // ===========================
  // Buttons
  // ===========================

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // ===========================
  // Navigation
  // ===========================

  static const TextStyle navItem = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle navItemActive = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}