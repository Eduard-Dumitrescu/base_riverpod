import 'package:base_riverpod/core/utils.dart';
import 'package:base_riverpod/features/theme_switch/data/theme_dao.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeModeKey = 'theme_mode_key';

class ThemeDaoSharedPrefs implements ThemeDao {
  final SharedPreferences _sharedPreferences;

  ThemeDaoSharedPrefs(this._sharedPreferences);

  @override
  Future<ThemeMode> getThemeMode() async =>
      _sharedPreferences
          .getInt(_themeModeKey)
          ?.nullOr((index) => ThemeMode.values[index]) ??
      ThemeMode.system;

  @override
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _sharedPreferences.setInt(_themeModeKey, themeMode.index);
}
