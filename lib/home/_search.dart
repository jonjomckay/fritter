import 'dart:async';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';

class TweetSearchDelegate extends SearchDelegate {
  final int initialTab;

  TweetSearchDelegate({ required this.initialTab });

  Future<List<TweetWithCard>> searchTweets(BuildContext context, String query) async {
    if (query.isEmpty) {
      return [];
    } else {
      // TODO: Is this right?
      return (await Twitter.searchTweets(query))
          .chains
          .map((e) => e.tweets)
          .expand((element) => element)
          .toList();
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
                TweetSearchResultList<User>(
                  query: query,
                    future: (q) => searchUsers(context, q),
                    itemBuilder: (context, item) {
                      return UserTile(
                        id: item.idStr!,
                        name: item.name!,
                        imageUri: item.profileImageUrlHttps!,
                        screenName: item.screenName!,
                        verified: item.verified!,
                      );
                    }
                ),
                TweetSearchResultList<TweetWithCard>(
                    query: query,
                    future: (q) => searchTweets(context, q),
                    itemBuilder: (context, item) {
                      return TweetTile(
                          tweet: item,
                          clickable: true
                      );
                    }
                ),
              ])),
            )
          ],
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class TweetSearchResultList<T> extends StatefulWidget {

  final String query;
  final Future<List<T>> Function(String query) future;
  final ItemWidgetBuilder<T> itemBuilder;

  const TweetSearchResultList({Key? key, required this.query, required this.future, required this.itemBuilder}) : super(key: key);

  @override
  _TweetSearchResultListState<T> createState() => _TweetSearchResultListState<T>();
}

class _TweetSearchResultListState<T> extends State<TweetSearchResultList<T>> {
  Timer? _debounce;
  late Future<List<T>> _future;

  @override
  void initState() {
    super.initState();

    fetchResults();
  }

  void fetchResults() {
    if (this.mounted) {
      setState(() {
        _future = widget.future(widget.query);
      });
    }
  }

  @override
  void didUpdateWidget(TweetSearchResultList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the current query is different from the last render's query, search
    if (oldWidget.query != widget.query) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }

      // Debounce the search, so we don't make a request per keystroke
      _debounce = Timer(const Duration(milliseconds: 750), () {
        fetchResults();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWrapper<List<T>>(
      future: _future,
      onError: (error, stackTrace) => FullPageErrorWidget(
        error: error,
        stackTrace: stackTrace,
        prefix: 'Unable to load the search results.',
        onRetry: () => fetchResults(),
      ),
      onReady: (items) {
        if (items.isEmpty) {
          return Center(child: Text('No results'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, items[index]);
          },
        );
      },
    );
  }
}
