import 'package:flutter/material.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/trends/_list.dart';
import 'package:fritter/trends/_settings.dart';
import 'package:fritter/trends/_tabs.dart';

class TrendsScreen extends StatelessWidget {
  final ScrollController scrollController;

  const TrendsScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrendsTabBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async => showDialog(
          context: context,
          builder: (context) => const TrendsSettings(),
        )
      ),
      body: TrendsList(scrollController: scrollController),
    );
  }
}
