import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/_feed.dart';
import 'package:fritter/home/_groups.dart';
import 'package:fritter/home/_saved.dart';
import 'package:fritter/search/search.dart';
import 'package:fritter/subscriptions/subscriptions.dart';
import 'package:fritter/trends/trends.dart';
import 'package:fritter/ui/physics.dart';
import 'package:fritter/utils/debounce.dart';
import 'package:pref/pref.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

class NavigationPage {
  final String id;
  final String title;
  final IconData icon;

  NavigationPage(this.id, this.title, this.icon);
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

final List<NavigationPage> homePages = [
  NavigationPage('feed', L10n.current.feed, Icons.rss_feed),
  NavigationPage('subscriptions', L10n.current.subscriptions, Icons.subscriptions),
  NavigationPage('groups', L10n.current.groups, Icons.group),
  NavigationPage('trending', L10n.current.trending, Icons.trending_up),
  NavigationPage('saved', L10n.current.saved, Icons.bookmark),
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

    return ScaffoldWithBottomNavigation(pages: homePages, selectedPage: selectedPage, builder: (scrollController) {
      return [
        ...homePages.map((e) {
          switch (e.id) {
            case 'feed':
              return FeedScreen(scrollController: scrollController, id: '-1', name: L10n.current.feed);
            case 'subscriptions':
              return SubscriptionsScreen(scrollController: scrollController);
            case 'groups':
              return GroupsScreen(scrollController: scrollController);
            case 'trending':
              return TrendsScreen(scrollController: scrollController);
            case 'saved':
              return SavedScreen(scrollController: scrollController);
            default:
            // TODO
              return Container();
          }
        })
      ];
    });
  }
}

class ScaffoldWithBottomNavigation extends StatefulWidget {
  final List<NavigationPage> pages;
  final int selectedPage;
  final List<Widget> Function(ScrollController scrollController) builder;

  const ScaffoldWithBottomNavigation({Key? key, required this.pages, required this.selectedPage, required this.builder}) : super(key: key);

  @override
  State<ScaffoldWithBottomNavigation> createState() => _ScaffoldWithBottomNavigationState();
}

class _ScaffoldWithBottomNavigationState extends State<ScaffoldWithBottomNavigation> {
  final ScrollController scrollController = ScrollController();

  late PageController _pageController;
  late List<Widget> _children;
  late int _selectedPage;

  @override
  void initState() {
    super.initState();

    _selectedPage = widget.selectedPage;

    _pageController = PageController(initialPage: _selectedPage);

    scrollController.bottomNavigationBar.setTab(_selectedPage);
    scrollController.bottomNavigationBar.tabListener((index) {
      _pageController.animateToPage(index, curve: Curves.easeInOut, duration: const Duration(milliseconds: 100));
      _selectedPage = index;
    });

    _children = widget.builder(scrollController);
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
        physics: const LessSensitiveScrollPhysics(),
        onPageChanged: (page) => Debouncer.debounce('page-change', const Duration(milliseconds: 200), () {
          scrollController.bottomNavigationBar.setTab(page);
        }),
        children: _children,
      ),
      bottomNavigationBar: ScrollBottomNavigationBar(
        controller: scrollController,
        showUnselectedLabels: true,
        items: [
          ...widget.pages.map((e) => BottomNavigationBarItem(
              icon: Icon(e.icon, size: 22),
              label: e.title
          ))
        ],
      ),
    );
  }
}
