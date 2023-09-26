import 'package:base_riverpod/features/theme_switch/presentation/theme_switch_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchWidget extends ConsumerWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(themeSwitchProvider);

    return Row(
      children: [
        Text('Current: $current'),
        ElevatedButton(
          onPressed: () => ref
              .read(themeSwitchProvider.notifier)
              .setThemeMode(ThemeMode.light),
          child: const Text('Light'),
        ),
        ElevatedButton(
          onPressed: () => ref
              .read(themeSwitchProvider.notifier)
              .setThemeMode(ThemeMode.dark),
          child: const Text('Dark'),
        ),
      ],
    );
  }
}
