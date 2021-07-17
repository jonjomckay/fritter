import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/home/_feed.dart';
import 'package:fritter/home/_saved.dart';
import 'package:fritter/subscriptions/subscriptions.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/trends/trends.dart';
import 'package:fritter/settings/settings.dart';
import 'package:fritter/user.dart';
import 'package:pref/pref.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _children = [
    FeedScreen(),
    SubscriptionsScreen(),
    TrendsScreen(),
    SavedScreen(),
  ];

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

class SubscriptionCheckboxList extends StatefulWidget {
  final List<Subscription> subscriptions;

  const SubscriptionCheckboxList({Key? key, required this.subscriptions}) : super(key: key);

  @override
  _SubscriptionCheckboxListState createState() => _SubscriptionCheckboxListState();
}

class _SubscriptionCheckboxListState extends State<SubscriptionCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return ReactiveFormArray<bool>(
          formArrayName: 'subscriptions',
          builder: (context, formArray, child) {
            var children = formArray.controls
                .asMap().entries
                .map((entry) {
                  var index = entry.key;
                  var value = entry.value;

                  var e = widget.subscriptions[index];

                  return CheckboxListTile(
                    dense: true,
                    secondary: ClipRRect(
                      borderRadius: BorderRadius.circular(64),
                      child: UserAvatar(uri: e.profileImageUrlHttps),
                    ),
                    title: Text(e.name),
                    subtitle: Text('@${e.screenName}'),
                    value: value.value ?? false,
                    onChanged: (v) {
                      if (v != null) {
                        value.value = v;
                      }
                    },
                  );
                })
                .toList(growable: false);

            return ListView(
                shrinkWrap: true,
                children: children
            );
          },
        );
      },
    );
  }
}
