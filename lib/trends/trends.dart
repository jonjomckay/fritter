import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/trends/_list.dart';
import 'package:fritter/trends/_settings.dart';
import 'package:fritter/trends/trends_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class TrendsScreen extends StatefulWidget with AppBarMixin {
  const TrendsScreen({Key? key}) : super(key: key);

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
      title: Text(L10n.current.trends),
      actions: createCommonAppBarActions(context),
    );
  }

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<TrendLocationModel>().loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: const _TabBar(),
      ),
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

class _TabBar extends StatefulWidget implements PreferredSizeWidget {
  const _TabBar({Key? key}) : super(key: key);

  @override
  State<_TabBar> createState() => _TabBarState();

  @override
  ui.Size get preferredSize => const ui.Size.fromHeight(46.0);
}

class _TabBarState extends State<_TabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    var model = context.read<TrendLocationModel>();
    var length = model.locations.length;
    _tabController = TabController(length: length, vsync: this);
    /*model.observer(onState: (location) {
      length = model.locations.length;
      _tabController.dispose();
      _tabController = TabController(length: length, vsync: this);
      setState(() {});
    });*/
  }

  List<Widget> _tabs(TrendLocationModel model) {
    return [
      ...model.locations.map((location) {
        return GestureDetector(
          //TODO: add remove-dialog / animation
          onLongPress: () => model.removeFromLocationsList(location),
          child: Tab(
            text: location.name,
          ),
        );
      }),
    ];
  }

  @override
  void didUpdateWidget(_TabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    var model = context.read<TrendLocationModel>();
    var length = model.locations.length;
    _tabController.dispose();
    _tabController = TabController(length: length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<TrendLocationModel>();
    print(model.locations);
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      onTap: (index) async {
        await model.setTrendLocation(model.locations[index]);
        //_tabController.animateTo(index);
      },
      tabs: _tabs(model),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
