import 'package:base_riverpod/features/root_wrapper/presentation/root_wrapper_widget.dart';
import 'package:base_riverpod/features/theme_switch/presentation/theme_switch_segmented_widget.dart';
import 'package:base_riverpod/features/theme_switch/presentation/theme_switch_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RootWrapperWidget(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ThemeSwitchMenuWidget(),
            ThemeSwitchSegmentedWidget(),
          ],
        ),
      ),
    );
  }
}
