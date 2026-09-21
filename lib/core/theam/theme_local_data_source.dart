import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme_type.dart';

class ThemeLocalDataSource {
  static const _key = 'app_theme_type';

  Future<void> saveThemeType(AppThemeType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, type.name);
  }

  Future<AppThemeType> loadThemeType() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return AppThemeType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => AppThemeType.light,
    );
  }
}