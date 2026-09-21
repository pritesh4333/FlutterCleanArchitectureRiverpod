import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/theam/app_theme_type.dart';
import 'package:stockholding/core/theam/theme_provider.dart';



class ThemePicker extends ConsumerWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(themeControllerProvider);

    return DropdownButton<AppThemeType>(
      value: current,
      items: AppThemeType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.name),
        );
      }).toList(),
      onChanged: (type) {
        if (type != null) {
          ref.read(themeControllerProvider.notifier).setThemeType(type);
        }
      },
    );
  }
}