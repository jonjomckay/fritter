import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_feed.dart';
import 'package:fritter/home/_groups.dart';
import 'package:fritter/home/_saved.dart';
import 'package:fritter/search/search.dart';
import 'package:fritter/subscriptions/subscriptions.dart';
import 'package:fritter/trends/trends.dart';
import 'package:fritter/ui/physics.dart';
import 'package:pref/pref.dart';
import 'package:fritter/generated/l10n.dart';

class Page {
  final String id;
  final String title;
  final IconData icon;

  Page(this.id, this.title, this.icon);
}

final List<Page> pages = [
  Page('feed', L10n.current.feed, Icons.rss_feed),
  Page('subscriptions', L10n.current.subscriptions, Icons.subscriptions),
  Page('groups', L10n.current.groups, Icons.group),
  Page('trending', L10n.current.trending, Icons.trending_up),
  Page('saved', L10n.current.saved, Icons.bookmark),
];

List<Widget> createCommonAppBarActions(BuildContext context) {
  return [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => Navigator.pushNamed(context, routeSearch, arguments: SearchArguments(0, focusInputOnOpen: true)),
    ),
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.pushNamed(context, routeSettings);
      },
    )
  ];
}

abstract class AppBarMixin {
  AppBar getAppBar(BuildContext context);
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
      _selectedPage = pages.indexWhere((element) => element.id == prefs.get(optionHomeInitialTab));
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
      if (page == null || page.round() == _selectedPage) {
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
    // TODO: Figure out how to do this properly, with the type system
    var appBarMixin = (_children[_selectedPage] as AppBarMixin);

    return Scaffold(
      appBar: appBarMixin.getAppBar(context),
      body: PageView(
        controller: _pageController,
        physics: const LessSensitiveScrollPhysics(),
        children: _children,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) => BottomNavigationBar(
          currentIndex: _selectedPage,
          showUnselectedLabels: true,
          onTap: (index) {
            _pageController.animateToPage(index, curve: Curves.easeInOut, duration: const Duration(milliseconds: 100));
          },
          items: [
            ...pages.map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.title
            ))
          ],
        ),
      ),
    );
  }
}
