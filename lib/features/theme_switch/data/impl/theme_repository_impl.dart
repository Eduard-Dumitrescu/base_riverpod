import 'dart:async';

import 'package:base_riverpod/features/theme_switch/data/theme_dao.dart';
import 'package:base_riverpod/features/theme_switch/domain/theme_repository.dart';
import 'package:flutter/material.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDao _themeDao;

  ThemeRepositoryImpl(this._themeDao);

  @override
  Future<void> setThemeMode(final ThemeMode themeMode) =>
      _themeDao.setThemeMode(themeMode);

  @override
  Stream<ThemeMode> get currentThemeMode => _themeDao.currentThemeMode;
}
