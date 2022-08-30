import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:pref/pref.dart';

class SettingsThemeFragment extends StatelessWidget with AppBarMixin {
  const SettingsThemeFragment({Key? key}) : super(key: key);

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(title: Text(L10n.current.theme));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(children: [
        PrefDropdown(fullWidth: false, title: Text(L10n.of(context).theme), pref: optionThemeMode, items: [
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
            fullWidth: false,
            pref: optionThemeColorScheme,
            items: FlexScheme.values
                .getRange(0, FlexScheme.values.length - 1)
                .map((scheme) => DropdownMenuItem(
                    value: scheme.name, child: Text(scheme.name.capitalize)))
                .toList()),
        PrefSwitch(
          title: Text(L10n.of(context).true_black),
          pref: optionThemeTrueBlack,
          subtitle: Text(
            L10n.of(context).use_true_black_for_the_dark_mode_theme,
          ),
        ),
      ]),
    );
  }
}
