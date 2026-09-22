import 'package:flutter/material.dart';
import 'app_fonts.dart';
import 'app_theme_type.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    fontFamily: AppFonts.fontName,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onSurface: Colors.black, // 👈 dedicated text color
    ),
  );

  static ThemeData dark = ThemeData(
    fontFamily: AppFonts.fontName,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onSurface: Colors.white,
    ),
  );

  static ThemeData blue = ThemeData(
    fontFamily: AppFonts.fontName,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      onSurface: Colors.white, // text stays white, blue reserved for accents
    ),
  );

  static ThemeData green = ThemeData(
    fontFamily: AppFonts.fontName,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      onSurface: Colors.black,
    ),
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