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

  List<Widget> getTabs(List<TrendLocation> locations, {required Function(TrendLocation) onDelete}) {
    _tabs.clear();
    return [
      ...locations.map((location) {
        return _LocationTab(
          location,
          onDelete: (location) => onDelete(location),
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

class _LocationTab extends StatelessWidget {
  final TrendLocation location;
  final Function(TrendLocation) onDelete;

  const _LocationTab(this.location, {Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (await removeTab(context, location)) {
          onDelete(location);
        }
      },
      child: Tab(
        text: location.name,
      ),
    );
  }

  Future<bool> removeTab(BuildContext context, TrendLocation location) async {
    bool delete = false;

    if (location.woeid != 1) {
      delete = await showMenu<bool>(
            context: context,
            position: _calcPosition(context),
            items: [
              PopupMenuItem(value: true, child: Text(L10n.of(context).delete)),
            ],
          ) ??
          false;
    }
    return delete;
  }

  RelativeRect _calcPosition(BuildContext context) {
    final RenderBox tab = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    return RelativeRect.fromRect(
      Rect.fromPoints(
        tab.localToGlobal(Offset.zero, ancestor: overlay),
        tab.localToGlobal(tab.size.bottomRight(Offset.zero) + Offset.zero, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }
}
