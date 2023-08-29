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

import '_account.dart';

class SettingsScreen extends StatefulWidget {
  final String? initialPage;

  const SettingsScreen({Key? key, this.initialPage}) : super(key: key);

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

    var pages = [
      NavigationPage('general', (c) => L10n.of(c).general, Icons.settings),
      NavigationPage('home', (c) => L10n.of(c).home, Icons.home),
      NavigationPage('theme', (c) => L10n.of(c).theme, Icons.format_paint),
      NavigationPage('data', (c) => L10n.of(c).data, Icons.storage),
      NavigationPage('account', (c) => L10n.of(c).account, Icons.account_box_sharp),
      NavigationPage('about', (c) => L10n.of(c).about, Icons.help),
    ];

    var initialPage = pages.indexWhere((element) => element.id == widget.initialPage);
    if (initialPage == -1) {
      initialPage = 0;
    }

    return ScaffoldWithBottomNavigation(
      initialPage: initialPage,
      pages: pages,
      builder: (scrollController) {
        return [
          const SettingsGeneralFragment(),
          const SettingsHomeFragment(),
          const SettingsThemeFragment(),
          SettingsDataFragment(legacyExportPath: _legacyExportPath),
          const SettingsAccountFragment(),
          SettingsAboutFragment(appVersion: appVersion)
        ];
      },
    );
  }
}
