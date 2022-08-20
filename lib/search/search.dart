import 'dart:async';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/search/search_model.dart';
import 'package:fritter/tweet/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';

class TweetSearchDelegate extends SearchDelegate {
  final int initialTab;

  TweetSearchDelegate({required this.initialTab});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
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
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: initialTab,
        child: Column(
          children: [
            Material(
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: const TabBar(tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.comment)),
              ]),
            ),
            Expanded(
                child: TabBarView(children: [
                  TweetSearchResultList<SearchUsersModel, User>(
                      query: query,
                      store: context.read<SearchUsersModel>(),
                      searchFunction: (q) => context.read<SearchUsersModel>().searchUsers(q),
                      itemBuilder: (context, item) => UserTile(user: item)),
                  TweetSearchResultList<SearchTweetsModel, TweetWithCard>(
                      query: query,
                      store: context.read<SearchTweetsModel>(),
                      searchFunction: (q) => context.read<SearchTweetsModel>().searchTweets(q),
                      itemBuilder: (context, item) {
                        return TweetTile(tweet: item, clickable: true);
                      }),
                ]))
          ],
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class TweetSearchResultList<S extends Store<Object, List<T>>, T> extends StatefulWidget {
  final String query;
  final S store;
  final Future<void> Function(String query) searchFunction;
  final ItemWidgetBuilder<T> itemBuilder;

  const TweetSearchResultList({Key? key, required this.query, required this.store, required this.searchFunction, required this.itemBuilder})
      : super(key: key);

  @override
  State<TweetSearchResultList<S, T>> createState() => _TweetSearchResultListState<S, T>();
}

class _TweetSearchResultListState<S extends Store<Object, List<T>>, T> extends State<TweetSearchResultList<S, T>> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    fetchResults();
  }

  void fetchResults() {
    if (mounted) {
      widget.searchFunction(widget.query);
    }
  }

  @override
  void didUpdateWidget(TweetSearchResultList<S, T> oldWidget) {
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
    return ScopedBuilder<S, Object, List<T>>.transition(
      store: widget.store,
      onLoading: (_) => const Center(child: CircularProgressIndicator()),
      onError: (_, error) => FullPageErrorWidget(
        error: error,
        stackTrace: null,
        prefix: L10n.of(context).unable_to_load_the_search_results,
        onRetry: () => fetchResults(),
      ),
      onState: (_, items) {
        if (items.isEmpty) {
          return Center(child: Text(L10n.of(context).no_results));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, items[index]);
          },
        );
      },
    );
  }
}