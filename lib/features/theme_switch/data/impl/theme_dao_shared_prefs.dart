import 'dart:async';

import 'package:base_riverpod/core/utils.dart';
import 'package:base_riverpod/features/theme_switch/data/theme_dao.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeModeKey = 'theme_mode_key';

class ThemeDaoSharedPrefs implements ThemeDao {
  final SharedPreferences _sharedPreferences;

  ThemeDaoSharedPrefs(this._sharedPreferences) {
    _updateThemeMode();
  }

  @override
  Stream<ThemeMode> get currentThemeMode =>
      _themeModeController.stream.distinct();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeModeController.add(themeMode);

    await _sharedPreferences.setInt(_themeModeKey, themeMode.index);
  }

  final StreamController<ThemeMode> _themeModeController =
      StreamController.broadcast();

  Future<void> _updateThemeMode() async {
    final ThemeMode themeMode = _sharedPreferences
            .getInt(_themeModeKey)
            ?.nullOr((index) => ThemeMode.values[index]) ??
        ThemeMode.system;

    _themeModeController.add(themeMode);
  }

  Future<void> onDispose() => _themeModeController.close();
}
