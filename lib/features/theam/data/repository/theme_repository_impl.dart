// data/repositories/theme_repository_impl.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import '../../domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  static const _key = 'theme_mode';

  @override
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name); // 'light' | 'dark' | 'system'
  }
}