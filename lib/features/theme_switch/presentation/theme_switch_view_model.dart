import 'package:base_riverpod/features/theme_switch/domain/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_switch_view_model.g.dart';

@riverpod
class ThemeSwitchViewModel extends _$ThemeSwitchViewModel {
  ThemeRepository get _themeRepository => ref.watch(themeRepositoryProvider);

  @override
  Stream<ThemeMode> build() => _themeRepository.currentThemeMode;

  Future<void> setThemeMode(final ThemeMode themeMode) async {
    if (state.value != themeMode) {
      await _themeRepository.setThemeMode(themeMode);
    }
  }
}
