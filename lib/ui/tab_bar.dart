import 'package:flutter/material.dart';

// Taken from https://stackoverflow.com/a/58776434, released under CC BY-SA 4.0
class TabBarWithFlexibleTabs extends StatefulWidget implements PreferredSizeWidget {
  TabBarWithFlexibleTabs({this.child});

  final TabBar child;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  _TabBarWithFlexibleTabsState createState() => _TabBarWithFlexibleTabsState();
}

class _TabBarWithFlexibleTabsState extends State<TabBarWithFlexibleTabs> {
  final _tabs = <Widget>[];
  final _tabsKeys = <Tab, GlobalKey>{};
  var _tabsPadding = 0.0;

  void _updateTabBarPadding() => setState(() {
        final screenWidth = MediaQuery.of(context).size.width;
        final tabBarWidth = _tabsKeys.values.fold(0, (prev, tab) => prev + tab.currentContext.size.width);
        _tabsPadding = tabBarWidth < screenWidth
            ? ((screenWidth - tabBarWidth) / widget.child.tabs.length) / 2
            : widget.child.labelPadding?.horizontal ?? 16.0;
      });

  @override
  void initState() {
    super.initState();
    widget.child.tabs.forEach((tab) => _tabsKeys[tab] = GlobalKey());
    _tabs.addAll(widget.child.tabs.map((tab) => Container(key: _tabsKeys[tab], child: tab)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabBarPadding());
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.child.controller,
      indicatorColor: widget.child.indicatorColor,
      tabs: _tabs,
      isScrollable: true,
      labelPadding: EdgeInsets.symmetric(
        horizontal: _tabsPadding,
        vertical: widget.child.labelPadding?.vertical ?? 0,
      ),
    );
  }
}
