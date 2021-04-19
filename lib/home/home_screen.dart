
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/home/_subscriptions.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home/_trends.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/options.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class _Tab {
  final String title;
  final IconData icon;

  _Tab(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final List<_Tab> _tabs = [
    _Tab('Trending', Icons.trending_up),
    _Tab('Subscriptions', Icons.people),
  ];
  
  late TabController _tabController;
  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();

    _currentTabIndex = 0;

    _tabController = TabController(vsync: this, length: _tabs.length);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
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
        title: Text(_tabs[_currentTabIndex].title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TweetSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OptionsScreen()));
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            ..._tabs.map((e) => Tab(
              icon: Icon(e.icon),
            ))
          ]
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: TabBarView(
          controller: _tabController,
          children: [
            TrendsContent(),
            SubscriptionsContent(),
          ],
        ),
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

                  // TODO: This is just copied from UserTile
                  var image = e.profileImageUrlHttps == null
                      ? Container(width: 48, height: 48)
                      : CachedNetworkImage(
                      imageUrl: e.profileImageUrlHttps!.replaceAll('normal', '200x200'),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error), // TODO: This can error if the profile image has changed... use SWR-like
                      width: 40,
                      height: 40
                  );

                  return CheckboxListTile(
                    dense: true,
                    secondary: ClipRRect(
                      borderRadius: BorderRadius.circular(64),
                      child: image,
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
