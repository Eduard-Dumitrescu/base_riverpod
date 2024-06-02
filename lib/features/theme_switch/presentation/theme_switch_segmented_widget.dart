import 'package:base_riverpod/features/theme_switch/presentation/theme_switch_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchSegmentedWidget extends ConsumerWidget {
  const ThemeSwitchSegmentedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode? currentThemeMode =
        ref.watch(themeSwitchViewModelProvider).valueOrNull;

    final String label = switch (currentThemeMode) {
      null => 'Unknown',
      _ => '',
    };

    return Row(
      children: [
        Text('Theme: $label'),
        const SizedBox(width: 8.0),
        if (currentThemeMode != null)
          Flexible(
            child: LayoutBuilder(builder: (context, constraints) {
              final double width = constraints.maxWidth;

              return SegmentedButton<ThemeMode>(
                showSelectedIcon: false,
                segments: <ButtonSegment<ThemeMode>>[
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.light,
                    label: width > 320 ? const Text('Light') : null,
                    icon: const Icon(Icons.light_mode_rounded),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.system,
                    label: width > 320 ? const Text('System') : null,
                    icon: const Icon(Icons.computer_rounded),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.dark,
                    label: width > 320 ? const Text('Dark') : null,
                    icon: const Icon(Icons.dark_mode_rounded),
                  ),
                ],
                selected: <ThemeMode>{currentThemeMode},
                onSelectionChanged: (Set<ThemeMode> newSelection) => ref
                    .read(themeSwitchViewModelProvider.notifier)
                    .setThemeMode(newSelection.first),
              );
            }),
          ),
      ],
    );
  }
}
