import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:pref/pref.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SettingsThemeFragment extends StatelessWidget {
  final ScrollController scrollController;

  const SettingsThemeFragment({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        title: Text(L10n.current.theme)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(controller: scrollController, children: [
          PrefDropdown(fullWidth: false, title: Text(L10n.of(context).theme_mode), pref: optionThemeMode, items: [
            DropdownMenuItem(
              value: 'system',
              child: Text(L10n.of(context).system),
            ),
            DropdownMenuItem(
              value: 'light',
              child: Text(L10n.of(context).light),
            ),
            DropdownMenuItem(
              value: 'dark',
              child: Text(L10n.of(context).dark),
            ),
          ]),
          PrefDropdown(
              title: Text(L10n.of(context).theme),
              fullWidth: false,
              pref: optionThemeColorScheme,
              items: FlexScheme.values
                  .getRange(0, FlexScheme.values.length - 1)
                  .sorted((a, b) => a.name.compareTo(b.name))
                  .map((scheme) => DropdownMenuItem(value: scheme.name, child: Text(scheme.name.capitalize)))
                  .toList()),
          PrefSwitch(
            title: Text(L10n.of(context).true_black),
            pref: optionThemeTrueBlack,
            subtitle: Text(
              L10n.of(context).use_true_black_for_the_dark_mode_theme,
            ),
          ),
        ]),
      ),
    );
  }
}
