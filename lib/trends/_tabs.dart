import 'package:dart_twitter_api/api/trends/data/trend_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/trends/trends_model.dart';
import 'package:provider/provider.dart';

class TrendsTabBar extends StatefulWidget implements PreferredSizeWidget {
  const TrendsTabBar({Key? key}) : super(key: key);

  @override
  State<TrendsTabBar> createState() => _TrendsTabBarState();

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

    model.observer(onState: (state) {
      _tabs = getTabs(state.locations, onLongPress: (location) => model.remove(location));
      _tabController = getController();
      _tabController.index = state.indexOfActive;
      setState(() {});
    });
  }

  List<Widget> getTabs(List<TrendLocation> locations, {Function(TrendLocation)? onLongPress}) {
    _tabs.clear();
    return [
      ...locations.map((location) {
        return GestureDetector(
          //TODO: add remove-dialog / animation
          onLongPress: () => onLongPress!(location),
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
