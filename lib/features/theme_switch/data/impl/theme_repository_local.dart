import 'dart:async';

import 'package:base_riverpod/features/theme_switch/data/theme_dao.dart';
import 'package:base_riverpod/features/theme_switch/domain/theme_repository.dart';
import 'package:flutter/material.dart';

class ThemeRepositoryLocal implements ThemeRepository {
  final ThemeDao _themeDao;

  ThemeRepositoryLocal(this._themeDao) {
    loadThemeMode();
  }

  final StreamController<ThemeMode> _themeModeController =
      StreamController.broadcast();

  @override
  Future<void> loadThemeMode() async =>
      _themeModeController.add(await _themeDao.getThemeMode());

  @override
  Future<void> setThemeMode(final ThemeMode themeMode) async {
    await _themeDao.setThemeMode(themeMode);

    _themeModeController.add(themeMode);
  }

  @override
  Stream<ThemeMode> get currentThemeMode =>
      _themeModeController.stream.distinct();

  Future<void> onDispose() => _themeModeController.close();
}
