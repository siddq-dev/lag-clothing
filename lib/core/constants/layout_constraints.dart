import 'package:flutter/material.dart';

class LayoutConstraints {
  LayoutConstraints._();

  /// Maximum width for website content.
  static const BoxConstraints website = BoxConstraints(
    maxWidth: 1400,
  );

  /// Maximum width for text-heavy content.
  static const BoxConstraints text = BoxConstraints(
    maxWidth: 550,
  );

  /// Maximum width for forms (login, register, etc.).
  static const BoxConstraints form = BoxConstraints(
    maxWidth: 450,
  );

  /// Maximum width for product descriptions.
  static const BoxConstraints productDescription = BoxConstraints(
    maxWidth: 650,
  );
}