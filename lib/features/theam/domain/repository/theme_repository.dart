// domain/repositories/theme_repository.dart
import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}