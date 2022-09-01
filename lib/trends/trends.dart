import 'package:flutter/material.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/trends/_list.dart';
import 'package:fritter/trends/_settings.dart';

import 'package:fritter/trends/_tabs.dart';

class TrendsScreen extends StatelessWidget with AppBarMixin {
  const TrendsScreen({Key? key}) : super(key: key);

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
      title: Text(L10n.current.trends),
      actions: createCommonAppBarActions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrendsTabBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async => showDialog(
          context: context,
          builder: (context) => const TrendsSettings(),
        ),
      ),
      body: const TrendsList(),
    );
  }
}
