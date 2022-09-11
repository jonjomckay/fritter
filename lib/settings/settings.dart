import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/settings/_about.dart';
import 'package:fritter/settings/_data.dart';
import 'package:fritter/settings/_general.dart';
import 'package:fritter/settings/_home.dart';
import 'package:fritter/settings/_theme.dart';
import 'package:fritter/utils/legacy.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo _packageInfo = PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');
  String _legacyExportPath = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      var packageInfo = await PackageInfo.fromPlatform();
      var legacyExportPath = await getLegacyPath(legacyExportFileName);

      setState(() {
        _packageInfo = packageInfo;
        _legacyExportPath = legacyExportPath;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var appVersion = 'v${_packageInfo.version}+${_packageInfo.buildNumber}';

    return ScaffoldWithBottomNavigation(
      selectedPage: 0,
      pages: [
        NavigationPage('general', (c) => L10n.of(c).general, Icons.settings),
        NavigationPage('home', (c) => L10n.of(c).home, Icons.home),
        NavigationPage('theme', (c) => L10n.of(c).theme, Icons.format_paint),
        NavigationPage('data', (c) => L10n.of(c).data, Icons.storage),
        NavigationPage('about', (c) => L10n.of(c).about, Icons.help),
      ],
      builder: (scrollController) {
        return [
          SettingsGeneralFragment(scrollController: scrollController),
          SettingsHomeFragment(scrollController: scrollController),
          SettingsThemeFragment(scrollController: scrollController),
          SettingsDataFragment(scrollController: scrollController, legacyExportPath: _legacyExportPath),
          SettingsAboutFragment(scrollController: scrollController, appVersion: appVersion)
        ];
      },
    );
  }
}
