import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RootWrapperWidget extends StatelessWidget {
  final Widget body;

  const RootWrapperWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appLocalizations.labelTitle),
      ),
      body:
          body, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
