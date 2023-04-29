import 'dart:convert';

import 'package:fritter/catcher/errors.dart';
import 'package:flutter/material.dart';
import 'package:fritter/catcher/errors.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/tweet/_video.dart';
import 'package:fritter/tweet/conversation.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class SubscriptionGroupFeed extends StatefulWidget {
  final SubscriptionGroupGet group;
  final List<SubscriptionGroupFeedChunk> chunks;
  final bool includeReplies;
  final bool includeRetweets;
  final ScrollController? scrollController;

  const SubscriptionGroupFeed(
      {Key? key,
      required this.group,
      required this.chunks,
      required this.includeReplies,
      required this.includeRetweets,
      this.scrollController})
      : super(key: key);

  @override
  State<SubscriptionGroupFeed> createState() => _SubscriptionGroupFeedState();
}

class _SubscriptionGroupFeedState extends State<SubscriptionGroupFeed> {
  late PagingController<String?, TweetChain> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) async {
      await _listTweets(cursor);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SubscriptionGroupFeed oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.includeReplies != widget.includeReplies || oldWidget.includeRetweets != widget.includeRetweets) {
      _pagingController.refresh();
    }
  }

  Future<String> createCursor(Database repository) async {
    return (await repository.insert(tableFeedGroupCursor, {}, nullColumnHack: 'id')).toString();
  }

  String _buildSearchQuery(List<Subscription> users) {
    var query = '';
    if (!widget.includeReplies) {
      query += '-filter:replies ';
    }

    if (!widget.includeRetweets) {
      query += '-filter:retweets ';
    } else {
      query += 'include:nativeretweets ';
    }

    var remainingLength = 490 - query.length;

    for (var user in users) {
      var queryToAdd = '';
      if (user is UserSubscription) {
        queryToAdd = 'from:${user.screenName}';
      } else if (user is SearchSubscription) {
        queryToAdd = '"${user.id}"';
      }

      // If we can add this user to the query and still be less than ~500 characters, do so
      if (query.length + queryToAdd.length < remainingLength) {
        if (query.isNotEmpty) {
          query += '+OR+';
        }

        query += queryToAdd;
      } else {
        // Otherwise, add the search future and start a new one
        assert(false, 'should never reach here');
        query = queryToAdd;
      }
    }

    return query;
  }

  /// Search for our next "page" of tweets.
  ///
  /// Here, each page is actually a set of mappings, where the ID of each set is the hash of all the user IDs in that
  /// set. We store this along with the top and bottom pagination cursors, which we use to perform pagination for all
  /// sets at the same time, allowing us to create a feed made up of individual search queries.
  Future _listTweets(String? cursorKey) async {
    try {
      List<Future<List<TweetChain>>> futures = [];

      var repository = await Repository.writable();
      var nextCursor = await createCursor(repository);

      for (var chunk in widget.chunks) {
        var hash = chunk.hash;
        
        futures.add(Future(() async {
          var tweets = <TweetChain>[];

          String? searchCursor;

          if (cursorKey == null) {
            // We're loading the initial content for the feed screen, so load all the chunks we already have
            var storedChunks = await repository.query(tableFeedGroupChunk, where: 'hash = ?', whereArgs: [hash], orderBy: 'created_at DESC');

            // Make sure we load any existing stored tweets from the chunk
            var storedChunksTweets = storedChunks
              .map((e) => jsonDecode(e['response'] as String))
              .map((e) => List.from(e))
              .expand((e) => e.map((c) => TweetChain.fromJson(c)))
              .toList();

            tweets.addAll(storedChunksTweets);

            // Use the latest chunk's top cursor to load any new tweets since the last time we checked
            var latestChunk = storedChunks.firstOrNull;
            if (latestChunk != null) {
              searchCursor = latestChunk['cursor_top'] as String;
            } else {
              // Otherwise we need to perform a fresh load from scratch for this chunk
              searchCursor = null;
            }
          } else {
            // We're currently at the end of our current feed, so load the oldest chunk and use its cursor to load more
            var storedChunks = await repository.query(tableFeedGroupChunk, where: 'cursor_id = ? AND hash = ?', whereArgs: [int.parse(cursorKey), hash]);
            if (storedChunks.isNotEmpty) {
              searchCursor = storedChunks.first['cursor_bottom'] as String;
            } else {
              searchCursor = null;
            }
          }

          // Perform our search for the next page of results for this chunk, and add those tweets to our collection
          var query = _buildSearchQuery(chunk.users);
          var result = await Twitter.searchTweets(query, widget.includeReplies, limit: 100, cursor: searchCursor);

          if (result.chains.isNotEmpty) {
            tweets.addAll(result.chains);

            // Make sure we insert the set of cursors for this latest chunk, ready for the next time we paginate
            await repository.insert(tableFeedGroupChunk, {
              'cursor_id': int.parse(nextCursor),
              'hash': hash,
              'cursor_top': result.cursorTop,
              'cursor_bottom': result.cursorBottom,
              'response': jsonEncode(result.chains.map((e) => e.toJson()).toList())
            });
          }

          return tweets;
        }));
      }

      // Wait for all our searches to complete, then build our list of tweet conversations
      var result = (await Future.wait(futures));
      var threads = result
          .expand((element) => element)
          .sorted((a, b) {
            var aCreatedAt = a.tweets[0].createdAt;
            var bCreatedAt = b.tweets[0].createdAt;

            if (aCreatedAt == null || bCreatedAt == null) {
              return 0;
            }

            return bCreatedAt.compareTo(aCreatedAt);
          })
          .toList();

      if (!mounted) {
        return;
      }

      if (result.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        // If this page is the same as the last page we received before, assume it's the last page
        if (nextCursor == _pagingController.nextPageKey) {
          _pagingController.appendLastPage([]);
        } else {
          _pagingController.appendPage(threads, nextCursor);
        }
      }
    } catch (e, stackTrace) {
      Catcher.reportException(e, stackTrace);
      if (mounted) {
        _pagingController.error = [e, stackTrace];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chunks.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(L10n.of(context).this_group_contains_no_subscriptions),
        ),
      );
    }

    var prefs = PrefService.of(context, listen: false);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<TweetContextState>(create: (_) => TweetContextState(prefs.get(optionTweetsHideSensitive))),
            ChangeNotifierProvider<VideoContextState>(create: (_) => VideoContextState(prefs.get(optionMediaDefaultMute))),
          ],
          child: PagedListView<String?, TweetChain>(
            padding: const EdgeInsets.only(top: 4),
            scrollController: widget.scrollController,
            pagingController: _pagingController,
            addAutomaticKeepAlives: false,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, conversation, index) {
                return TweetConversation(
                    id: conversation.id, username: null, tweets: conversation.tweets, isPinned: conversation.isPinned);
              },
              newPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
                error: _pagingController.error[0],
                stackTrace: _pagingController.error[1],
                prefix: L10n.of(context).unable_to_load_the_next_page_of_tweets,
                onRetry: () => _listTweets(_pagingController.firstPageKey),
              ),
              firstPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
                error: _pagingController.error[0],
                stackTrace: _pagingController.error[1],
                prefix: L10n.of(context).unable_to_load_the_tweets_for_the_feed,
                onRetry: () => _listTweets(_pagingController.nextPageKey),
              ),
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text(
                  L10n.of(context).could_not_find_any_tweets_from_the_last_7_days,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
