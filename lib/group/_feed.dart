import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/tweet/conversation.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SubscriptionGroupFeed extends StatefulWidget {
  final SubscriptionGroupGet group;
  final List<String> users;
  final bool includeReplies;
  final bool includeRetweets;
  final ScrollController? scrollController;

  const SubscriptionGroupFeed(
      {Key? key,
      required this.group,
      required this.users,
      required this.includeReplies,
      required this.includeRetweets,
      this.scrollController})
      : super(key: key);

  @override
  _SubscriptionGroupFeedState createState() => _SubscriptionGroupFeedState();
}

class _SubscriptionGroupFeedState extends State<SubscriptionGroupFeed> {
  late PagingController<String?, TweetChain> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _listTweets(cursor);
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

  Future _listTweets(String? cursor) async {
    try {
      List<Future<TweetStatus>> futures = [];

      // TODO: Split into groups, and have a max_id per group
      var query = '';
      if (!widget.includeReplies) {
        query += '-filter:replies ';
      }

      if (!widget.includeRetweets) {
        query += '-filter:retweets ';
      }

      var remainingLength = 490 - query.length;

      for (var user in widget.users) {
        var queryToAdd = 'from:$user';

        // If we can add this user to the query and still be less than ~500 characters, do so
        if (query.length + queryToAdd.length < remainingLength) {
          if (query.isNotEmpty) {
            query += '+OR+';
          }

          query += queryToAdd;
        } else {
          // Otherwise, add the search future and start a new one
          futures.add(Twitter.searchTweets(query, limit: 100, cursor: cursor, mode: 'live'));

          query = queryToAdd;
        }
      }

      // Add any remaining query as a search future too
      futures.add(Twitter.searchTweets(query, limit: 100, cursor: cursor, mode: 'live'));

      var result = (await Future.wait(futures));
      var threads = result
          .map((e) => e.chains)
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

      if (result.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        // If this page is the same as the last page we received before, assume it's the last page
        if (result.last.cursorBottom == _pagingController.nextPageKey) {
          _pagingController.appendLastPage([]);
        } else {
          _pagingController.appendPage(threads, result.last.cursorBottom);
        }
      }
    } catch (e, stackTrace) {
      Catcher.reportCheckedError(e, stackTrace);
      if (mounted) {
        _pagingController.error = [e, stackTrace];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.users.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(L10n.of(context).this_group_contains_no_subscriptions),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: PagedListView<String?, TweetChain>(
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
    );
  }
}
