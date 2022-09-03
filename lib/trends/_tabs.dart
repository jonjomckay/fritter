import 'package:dart_twitter_api/api/trends/data/trend_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/trends/trends_model.dart';
import 'package:provider/provider.dart';

class TrendsTabBar extends StatefulWidget implements PreferredSizeWidget {
  const TrendsTabBar({Key? key}) : super(key: key);

  @override
  State<TrendsTabBar> createState() => _TrendsTabBarState();

  /// I needed to implement [PreferredSizeWidget], to add [TrendsTabBar] as an Scaffold AppBar.
  /// unfortunately I'm not sure how to handle the [preferredSize] property correctly.
  /// Documentation only says:
  /// In many cases it's only necessary to define one preferred dimension.
  /// For example the [Scaffold] only depends on its app bar's preferred
  /// height. In that case implementations of this method can just return
  /// `new Size.fromHeight(myAppBarHeight)`.
  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _TrendsTabBarState extends State<TrendsTabBar> with TickerProviderStateMixin {
  late TabController _tabController;

  List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
    var model = context.read<UserTrendLocationModel>();
    model.loadTrendLocation();

    _tabs = [];
    _tabController = getController();

    model.observer(onState: (state) {
      _tabs = getTabs(state.locations, onDelete: (location) async => await model.remove(location));
      _tabController = getController();
      _tabController.index = state.indexOfActive;
      setState(() {});
    });
  }

  List<Widget> getTabs(List<TrendLocation> locations, {Function(TrendLocation)? onDelete}) {
    _tabs.clear();
    return [
      ...locations.map((location) {
        return GestureDetector(
          onLongPress: () async {
            //the dialog won't pop up on worldwide trend
            if (location.woeid != 1) {
              bool? delete = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return _Delete(location);
                  });
              if (delete ?? false) {
                onDelete!(location);
              }
            }
          },
          child: Tab(
            text: location.name,
          ),
        );
      }),
    ];
  }

  TabController getController() => TabController(length: _tabs.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    var model = context.read<UserTrendLocationModel>();

    return ScopedBuilder<UserTrendLocationModel, Object, UserTrendLocations>(
      store: context.read<UserTrendLocationModel>(),
      onState: (context, state) {
        return AppBar(
          bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              onTap: (index) async {
                await model.change(state.locations[index]);
              },
              tabs: _tabs),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _Delete extends StatelessWidget {
  final TrendLocation location;

  const _Delete(this.location, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // TODO: add proper "remove Trend" dialag
      title: Text(L10n().delete),
      content: Text("${location.name}"),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context, true);
          },
          child: Text(L10n.of(context).yes),
        ),
      ],
    );
  }
}
