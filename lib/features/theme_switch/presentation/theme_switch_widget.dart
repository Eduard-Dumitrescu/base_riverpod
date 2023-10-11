import 'package:base_riverpod/features/theme_switch/presentation/current_theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchWidget extends ConsumerWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => ref
              .read(currentThemeProvider.notifier)
              .setThemeMode(ThemeMode.light),
          child: const Text('Light'),
        ),
        ElevatedButton(
          onPressed: () => ref
              .read(currentThemeProvider.notifier)
              .setThemeMode(ThemeMode.dark),
          child: const Text('Dark'),
        ),
      ],
    );
  }
}
