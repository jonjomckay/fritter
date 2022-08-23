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

class NavigationPage {
  final String id;
  final String title;
  final IconData icon;
  final Widget child;

  NavigationPage(this.id, this.title, this.icon, this.child);
}

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

final List<NavigationPage> homePages = [
  NavigationPage('feed', L10n.current.feed, Icons.rss_feed, FeedScreen()),
  NavigationPage('subscriptions', L10n.current.subscriptions, Icons.subscriptions, const SubscriptionsScreen()),
  NavigationPage('groups', L10n.current.groups, Icons.group, const GroupsScreen()),
  NavigationPage('trending', L10n.current.trending, Icons.trending_up, const TrendsScreen()),
  NavigationPage('saved', L10n.current.saved, Icons.bookmark, const SavedScreen()),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If we have an initial tab set, use it as the initial index
    int selectedPage = 0;

    var prefs = PrefService.of(context, listen: false);
    if (prefs.getKeys().contains(optionHomeInitialTab)) {
      selectedPage = homePages.indexWhere((element) => element.id == prefs.get(optionHomeInitialTab));
    }

    return ScaffoldWithBottomNavigation(pages: homePages, selectedPage: selectedPage);
  }
}

class ScaffoldWithBottomNavigation extends StatefulWidget {
  final List<NavigationPage> pages;
  final int selectedPage;

  const ScaffoldWithBottomNavigation({Key? key, required this.pages, required this.selectedPage}) : super(key: key);

  @override
  State<ScaffoldWithBottomNavigation> createState() => _ScaffoldWithBottomNavigationState();
}

class _ScaffoldWithBottomNavigationState extends State<ScaffoldWithBottomNavigation> {
  late PageController _pageController;
  late int _selectedPage = 0;

  @override
  void initState() {
    super.initState();

    _selectedPage = widget.selectedPage;

    _pageController = PageController(initialPage: widget.selectedPage);
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
    var appBarMixin = (widget.pages[_selectedPage].child as AppBarMixin);

    return Scaffold(
      appBar: appBarMixin.getAppBar(context),
      body: PageView(
        controller: _pageController,
        physics: const LessSensitiveScrollPhysics(),
        children: widget.pages.map((e) => e.child).toList(),
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
            ...widget.pages.map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.title
            ))
          ],
        ),
      ),
    );
  }
}
