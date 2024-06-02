import 'dart:async';

import 'package:base_riverpod/core/utils.dart';
import 'package:base_riverpod/features/theme_switch/data/theme_dao.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeModeKey = 'theme_mode_key';

class ThemeDaoSharedPrefs implements ThemeDao {
  final SharedPreferences _sharedPreferences;

  ThemeDaoSharedPrefs(this._sharedPreferences);

  @override
  Stream<ThemeMode> get currentThemeMode => _themeMode.stream.distinct();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeMode.add(themeMode);

    await _sharedPreferences.setInt(_themeModeKey, themeMode.index);
  }

  late final BehaviorSubject<ThemeMode> _themeMode = BehaviorSubject.seeded(
    _sharedPreferences
            .getInt(_themeModeKey)
            ?.nullOr((index) => ThemeMode.values[index]) ??
        ThemeMode.system,
  );

  Future<void> onDispose() => _themeMode.close();
}
