import 'package:base_riverpod/core/storage/storage_module.dart';
import 'package:base_riverpod/features/theme_switch/data/impl/theme_dao_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_dao.g.dart';

abstract interface class ThemeDao {
  Future<ThemeMode> getThemeMode();

  Future<void> setThemeMode(final ThemeMode themeMode);
}

@riverpod
ThemeDao themeDao(ThemeDaoRef ref) =>
    ThemeDaoSharedPrefs(ref.watch(sharedPreferencesProvider));
