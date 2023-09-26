import 'package:base_riverpod/features/theme_switch/domain/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_switch_notifier.g.dart';

@riverpod
class ThemeSwitch extends _$ThemeSwitch {
  ThemeRepository get themeRepository => ref.watch(themeRepositoryProvider);

  @override
  Stream<ThemeMode> build() => themeRepository.currentThemeMode;

  Future<void> setThemeMode(final ThemeMode themeMode) =>
      themeRepository.setThemeMode(themeMode);
}
