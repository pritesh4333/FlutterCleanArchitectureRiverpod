import 'package:flutter/material.dart';
import 'app_fonts.dart';
import 'app_theme_type.dart';

class AppTheme {
  AppTheme._();

  /// Builds a [ThemeData] from [scheme] so every theme gets the same
  /// theme-derived styling (fonts, snackbar contrast) without repeating it.
  static ThemeData _build(ColorScheme scheme) => ThemeData(
    fontFamily: AppFonts.fontName,
    brightness: scheme.brightness,
    colorScheme: scheme,
    // 👈 snackbar text must contrast with the snackbar surface, not the screen
    snackBarTheme: SnackBarThemeData(
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: TextStyle(
        color: scheme.onInverseSurface,
        fontFamily: AppFonts.fontName,
      ),
    ),
  );

  static ThemeData light = _build(
    const ColorScheme.light(
      primary: Colors.black,
      onSurface: Colors.black, // 👈 dedicated text color
    ),
  );

  static ThemeData dark = _build(
    const ColorScheme.dark(primary: Colors.white, onSurface: Colors.white),
  );

  static ThemeData blue = _build(
    const ColorScheme.dark(
      primary: Colors.blue,
      onSurface: Colors.white, // text stays white, blue reserved for accents
    ),
  );

  static ThemeData green = _build(
    const ColorScheme.light(primary: Colors.green, onSurface: Colors.black),
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