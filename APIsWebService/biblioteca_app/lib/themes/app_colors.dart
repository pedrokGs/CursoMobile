import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryLight = Color(0xFF8C6239);
  static const Color backgroundLight = Color(0xFFF9F6F1);
  static const Color widgetBackgroundLight = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF2E2E2E);
  static const Color secondaryTextLight = Color(0xFF6E6E6E);
  static const Color successLight = Color(0xFF81C784);
  static const Color errorLight = Color(0xFFFC8181);
  static const Color accentLight = Color(0xFFD4AF37);

  static const Color primaryDark = Color(0xFFC19A6B);
  static const Color textDark = Color(0xFFF5F5F5);
  static const Color widgetBackgroundDark = Color(0xFF2C2C2C);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color successDark = Color(0xFF66BB6A);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color accentDark = Color(0xFFFFD700);


  static ColorScheme getColorScheme(bool isDark) {
    return isDark
        ? const ColorScheme.dark(
          primary: primaryDark,
          onPrimary: textDark,
          onError: errorDark,
          error: errorDark,
          surface: backgroundDark,
          onPrimaryContainer: textDark,
          onSurface: textDark,
          secondary: accentDark
        )
        : const ColorScheme.light(
          primary: primaryLight,
          surface: backgroundLight,
          secondary: accentLight,
          onPrimary: textLight,
          onError: errorLight,
          error: errorLight,
          onPrimaryContainer: textLight,
          onSurface: textLight,
        );
  }

}