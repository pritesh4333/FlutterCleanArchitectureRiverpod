// presentation/providers/theme_providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/theme_repository_impl.dart';
import '../../domain/repository/theme_repository.dart';
import '../controllers/theme_controller.dart';

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return ThemeRepositoryImpl();
});

final themeControllerProvider =
StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController(ref.watch(themeRepositoryProvider));
});