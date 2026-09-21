import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/theam/theme_local_data_source.dart';

 import 'app_theme.dart';
import 'app_theme_type.dart';

final themeLocalDataSourceProvider = Provider<ThemeLocalDataSource>((ref) {
  return ThemeLocalDataSource();
});

class ThemeController extends StateNotifier<AppThemeType> {
  ThemeController(this._dataSource, AppThemeType initial) : super(initial);

  final ThemeLocalDataSource _dataSource;

  Future<void> setThemeType(AppThemeType type) async {
    state = type;
    await _dataSource.saveThemeType(type);
  }
}

final themeControllerProvider = StateNotifierProvider<ThemeController, AppThemeType>((ref) {
  final dataSource = ref.watch(themeLocalDataSourceProvider);
  return ThemeController(dataSource, AppThemeType.light);
});

/// Derived provider — the actual ThemeData MaterialApp needs
final currentThemeDataProvider = Provider<ThemeData>((ref) {
  final type = ref.watch(themeControllerProvider);
  return AppTheme.fromType(type);
});