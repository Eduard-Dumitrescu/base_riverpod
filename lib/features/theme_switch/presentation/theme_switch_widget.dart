import 'package:base_riverpod/features/theme_switch/presentation/theme_switch_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchMenuWidget extends ConsumerWidget {
  const ThemeSwitchMenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ThemeMode? currentThemeMode =
        ref.watch(themeSwitchViewModelProvider).valueOrNull;

    final String label = switch (currentThemeMode) {
      ThemeMode.system => appLocalizations.labelSystemTheme,
      ThemeMode.light => appLocalizations.labelLightTheme,
      ThemeMode.dark => appLocalizations.labelDarkTheme,
      null => appLocalizations.labelUnknown,
    };

    return MenuBar(
      children: [
        SubmenuButton(
          menuChildren: ThemeMode.values
              .map(
                (themeMode) => MenuItemButton(
                  onPressed: () => ref
                      .read(themeSwitchViewModelProvider.notifier)
                      .setThemeMode(themeMode),
                  leadingIcon: Icon(
                    switch (themeMode) {
                      ThemeMode.system => Icons.computer,
                      ThemeMode.light => Icons.light_mode,
                      ThemeMode.dark => Icons.dark_mode,
                    },
                  ),
                  child: Text(themeMode.name),
                ),
              )
              .toList(growable: false),
          child: Text('${appLocalizations.labelTheme}: $label'),
        ),
      ],
    );
  }
}
