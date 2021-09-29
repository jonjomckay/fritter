import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_feed.dart';
import 'package:fritter/home/_saved.dart';
import 'package:fritter/subscriptions/subscriptions.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/trends/trends.dart';
import 'package:pref/pref.dart';

class _Tab {
  final String id;
  final String title;
  final IconData icon;

  _Tab(this.id, this.title, this.icon);
}

final List<_Tab> homeTabs = [
  _Tab('feed', 'Feed', Icons.rss_feed),
  _Tab('subscriptions', 'Subscriptions', Icons.people),
  _Tab('trending', 'Trending', Icons.trending_up),
  _Tab('saved', 'Saved', Icons.bookmark),
];

final int feedTabIndex = homeTabs.indexWhere((element) => element.id == 'feed');

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late List<Widget> _children;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    int initialIndex = 0;

    // If we have an initial tab set, use it as the initial index
    var prefs = PrefService.of(context, listen: false);
    if (prefs.getKeys().contains(OPTION_HOME_INITIAL_TAB)) {
      initialIndex = homeTabs.indexWhere((element) => element.id == prefs.get(OPTION_HOME_INITIAL_TAB));
    }

    _children = [
      FeedScreen(scrollController: _scrollController),
      SubscriptionsScreen(),
      TrendsScreen(),
      SavedScreen(),
    ];

    _tabController = TabController(vsync: this, initialIndex: initialIndex, length: homeTabs.length);
    _tabController.addListener(() {
      setState(() {});
    });
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeTabs[_tabController.index].title),
        actions: [
          if (_tabController.index == feedTabIndex)
            IconButton(icon: Icon(Icons.arrow_upward), onPressed: () async {
              await _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            }),
          if (_tabController.index == feedTabIndex)
            IconButton(icon: Icon(Icons.refresh), onPressed: () async {
              // This is a dirty hack, and probably won't work if the child widgets ever become stateful
              setState(() {});
            }),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TweetSearchDelegate(
                initialTab: 0
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, ROUTE_SETTINGS);
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            ...homeTabs.map((e) => Tab(
              icon: Icon(e.icon),
            ))
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _children,
      ),
    );
  }
}