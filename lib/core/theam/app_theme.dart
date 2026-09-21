import 'package:flutter/material.dart';
import 'app_fonts.dart';
import 'app_theme_type.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    fontFamily: AppFonts.rethinkSans,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(primary: Colors.black),
  );

  static ThemeData dark = ThemeData(
    fontFamily: AppFonts.rethinkSans,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(primary: Colors.white),
  );

  static ThemeData blue = ThemeData(
    fontFamily: AppFonts.rethinkSans,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
  );

  static ThemeData green = ThemeData(
    fontFamily: AppFonts.rethinkSans,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(primary: Colors.green),
  );

  static ThemeData fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return light;
      case AppThemeType.dark:
        return dark;
      case AppThemeType.blue:
        return blue;
      case AppThemeType.green:
        return green;
    }
  }
}