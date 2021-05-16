import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet.dart';
import 'package:fritter/user.dart';

class TweetSearchDelegate extends SearchDelegate {
  final int initialTab;

  TweetSearchDelegate({ required this.initialTab });

  Future<List<TweetWithCard>> searchTweets(BuildContext context, String query) async {
    if (query.isEmpty) {
      return [];
    } else {
      return await Twitter.searchTweets(query);
    }
  }

  Future<List<User>> searchUsers(BuildContext context, String query) async {
    if (query.isEmpty) {
      return [];
    } else {
      return await Twitter.searchUsers(query);
    }
  }

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
    return DefaultTabController(
        length: 2,
        initialIndex: initialTab,
        child: Column(
          children: [
            Container(
              child: Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: TabBar(tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.comment)),
                ]),
              ),
            ),
            Container(
              child: Expanded(child: TabBarView(children: [
                FutureBuilder<List<User>>(
                  future: searchUsers(context, query),
                  builder: (context, snapshot) {
                    return TweetSearchResultList<User>(snapshot: snapshot, itemBuilder: (context, item) {
                      return UserTile(
                          id: item.idStr!,
                          name: item.name!,
                          imageUri: item.profileImageUrlHttps!,
                          screenName: item.screenName!
                      );
                    });
                  },
                ),
                FutureBuilder<List<TweetWithCard>>(
                  future: searchTweets(context, query),
                  builder: (context, snapshot) {
                    return TweetSearchResultList<TweetWithCard>(snapshot: snapshot, itemBuilder: (context, item) {
                      return TweetTile(
                          tweet: item,
                          clickable: true
                      );
                    });
                  },
                ),
              ])),
            )
          ],
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class TweetSearchResultList<T> extends StatelessWidget {

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  const TweetSearchResultList({Key? key, required this.snapshot, required this.itemBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      var error = snapshot.error as Exception;

      return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Oops! Something went wrong 🥲', style: TextStyle(
                fontSize: 18
            )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text('$error', style: TextStyle(
                  color: Theme.of(context).hintColor
              )),
            )
          ],
        ),
      );
    }

    var items = snapshot.data;
    if (items == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text('No results'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}
