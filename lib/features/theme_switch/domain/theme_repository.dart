import 'package:base_riverpod/features/theme_switch/data/impl/theme_repository_impl.dart';
import 'package:base_riverpod/features/theme_switch/data/theme_dao.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_repository.g.dart';

abstract interface class ThemeRepository {
  Future<void> setThemeMode(final ThemeMode themeMode);

  Stream<ThemeMode> get currentThemeMode;
}

@riverpod
ThemeRepository themeRepository(ThemeRepositoryRef ref) =>
    ThemeRepositoryImpl(ref.watch(themeDaoProvider));
