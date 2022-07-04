import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_feed.dart';
import 'package:fritter/home/_groups.dart';
import 'package:fritter/home/_saved.dart';
import 'package:fritter/subscriptions/subscriptions.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/trends/trends.dart';
import 'package:pref/pref.dart';
import 'package:fritter/generated/l10n.dart';

class _Tab {
  final String id;
  final String title;
  final IconData icon;

  _Tab(this.id, this.title, this.icon);
}

final List<_Tab> homeTabs = [
  _Tab('feed', L10n.current.feed, Icons.rss_feed),
  _Tab('subscriptions', L10n.current.subscriptions, Icons.subscriptions),
  _Tab('groups', L10n.current.groups, Icons.group),
  _Tab('trending', L10n.current.trending, Icons.trending_up),
  _Tab('saved', L10n.current.saved, Icons.bookmark),
];

final int feedTabIndex = homeTabs.indexWhere((element) => element.id == 'feed');
final int groupsTabIndex = homeTabs.indexWhere((element) => element.id == 'groups');
final int subscriptionsTabIndex = homeTabs.indexWhere((element) => element.id == 'subscriptions');

List<Widget> createCommonAppBarActions(BuildContext context) {
  return [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(context: context, delegate: TweetSearchDelegate(initialTab: 0));
      },
    ),
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.pushNamed(context, routeSettings);
      },
    )
  ];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late PageController _pageController;
  late int _selectedPage = 0;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();

    // If we have an initial tab set, use it as the initial index
    var prefs = PrefService.of(context, listen: false);
    if (prefs.getKeys().contains(optionHomeInitialTab)) {
      _selectedPage = homeTabs.indexWhere((element) => element.id == prefs.get(optionHomeInitialTab));
    }

    _children = [
      FeedScreen(scrollController: _scrollController),
      const SubscriptionsScreen(),
      const GroupsScreen(),
      const TrendsScreen(),
      const SavedScreen(),
    ];

    _pageController = PageController(initialPage: _selectedPage);
    _pageController.addListener(() {
      var page = _pageController.page;
      if (page == null) {
        return;
      }

      setState(() {
        _selectedPage = page.round();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _children,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) => BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (index) {
            _pageController.animateToPage(index, curve: Curves.easeInOut, duration: const Duration(milliseconds: 100));
          },
          items: [
            ...homeTabs.map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.title
            ))
          ],
        ),
      ),
    );
  }
}
