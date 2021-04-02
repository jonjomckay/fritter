import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database.dart';
import 'package:fritter/database/entities.dart';
import 'package:intl/intl.dart';

import 'options.dart';
import 'profile.dart';

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
    _Tab('Following', Icons.people),
  ];
  
  late TabController _tabController;
  late int _currentTabIndex;
  late Future<List<Trends>> _trendsFuture;

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

    setState(() {
      _trendsFuture = Twitter.getTrends();
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
              showSearch(context: context, delegate: TweetSearch());
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
      body: TabBarView(
        controller: _tabController,
        children: [
          TrendsContent(trendsFuture: _trendsFuture),
          FollowingContent(),
        ],
      ),
    );
  }
}

class TweetSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return DefaultTabController(length: 2, child: Column(
      children: [
        TabBar(tabs: [
          Tab(icon: Icon(Icons.comment)),
          Tab(icon: Icon(Icons.person)),
        ]),
        TabBarView(children: [
          Text('1'),
          Text('2'),
          // _tweets.isEmpty && _oldSearch != null
          //     ? Center(child: Text('No results'))
          //     : ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: _tweets.length,
          //   itemBuilder: (context, index) => TweetTile(tweet: _tweets[index], clickable: true),
          // ),
          // _users.isEmpty && _oldSearch != null
          //     ? Center(child: Text('No results'))
          //     : ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: _users.length,
          //   itemBuilder: (context, index) => UserTile(user: _users[index]),
          // )
        ])
      ],
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}

class TrendsContent extends StatelessWidget {
  final trendsFuture;

  const TrendsContent({Key? key, required this.trendsFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Trends>>(
        future: trendsFuture,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(child: CircularProgressIndicator());
          }

          var trends = data[0].trends;
          if (trends == null) {
            return Text('TODO');
          }

          var numberFormat = NumberFormat.compact();

          return ListView(
            children: [
              Container(
                child: ListTile(
                  title: Text('Worldwide trends', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: trends.length,
                itemBuilder: (context, index) {
                  var trend = trends[index];

                  return ListTile(
                    dense: true,
                    leading: Text('${++index}'),
                    title: Text('${trend.name!}'),
                    subtitle: trend.tweetVolume == null
                        ? null
                        : Text('${numberFormat.format(trend.tweetVolume)} tweets'),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}

class FollowingContent extends StatefulWidget {
  @override
  _FollowingContentState createState() => _FollowingContentState();
}

class _FollowingContentState extends State<FollowingContent> {
  late Future<List<Following>> _future;


  @override
  void initState() {
    super.initState();

    setState(() {
      this._future = listFollowing();
    });
  }

  Future<List<Following>> listFollowing() async {
    var database = await Repository.open();

    return (await database.query('following'))
        .map((e) => Following.fromMap(e))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Following>>(
        future: _future,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(child: CircularProgressIndicator());
          }

          // TODO: Make this happen pre-future value?
          data.sort((a, b) => a.screenName.compareTo(b.screenName));

          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var user = data[index];

              return ListTile(
                dense: true,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(64),
                  child: CachedNetworkImage(
                      imageUrl: user.profileImageUrlHttps!, // TODO
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error), // TODO: This can error if the profile image has changed... use SWR-like
                      width: 48,
                      height: 48
                  ),
                ),
                title: Text(user.name),
                subtitle: Text('@${user.screenName}'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: user.screenName)));
                },
              );
            },
          );
        },
      ),
    );
  }
}

