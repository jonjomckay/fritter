import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TweetConversation extends StatefulWidget {
  final String id;
  final String? username;
  final bool showFullThread;
  final List<TweetWithCard> tweets;

  const TweetConversation({Key? key, required this.id, required this.username, required this.showFullThread, required this.tweets}) : super(key: key);

  @override
  _TweetConversationState createState() => _TweetConversationState();
}

class _TweetConversationState extends State<TweetConversation> {
  @override
  Widget build(BuildContext context) {
    if (widget.tweets.length == 1) {
      return TweetTile(clickable: true, tweet: widget.tweets.first, currentUsername: widget.username);
    }

    List<TweetTile> tiles = [];

    if (widget.showFullThread) {
      for (var tweet in widget.tweets.sorted((a, b) => a.idStr!.compareTo(b.idStr!))) {
        tiles.add(TweetTile(clickable: true, tweet: tweet, currentUsername: widget.username));
      }
    } else {
      tiles.add(TweetTile(clickable: true, tweet: widget.tweets[0], currentUsername: widget.username, thread: widget.id));
    }

    return Container(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Column(
              children: [
                ...tiles,
              ],
            )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                color: Colors.blue,
                width: 4,
              )
          ],
        ),
      ),
    );
  }
}


class ProfileTweets extends StatefulWidget {
  final User user;
  final String type;
  final bool includeReplies;

  const ProfileTweets({Key? key, required this.user, required this.type, required this.includeReplies}) : super(key: key);

  @override
  _ProfileTweetsState createState() => _ProfileTweetsState();
}

class _ProfileTweetsState extends State<ProfileTweets> {
  late PagingController<String?, TweetChain> _pagingController;

  int _pageSize = 50;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _loadTweets(cursor);
    });
  }

  Future _loadTweets(String? cursor) async {
    try {
      var result = await Twitter.getTweets(
        widget.user.idStr!,
        widget.type,
        cursor: cursor,
        count: _pageSize,
        includeReplies: widget.includeReplies
      );

      if (result.cursorBottom == _pagingController.nextPageKey) {
        _pagingController.appendLastPage([]);
      } else {
        _pagingController.appendPage(result.chains, result.cursorBottom);
      }
    } catch (e, stackTrace) {
      _pagingController.error = [e, stackTrace];
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<String?, TweetChain>(
      padding: EdgeInsets.zero,
      pagingController: _pagingController,
      addAutomaticKeepAlives: false,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, conversation, index) {
          return TweetConversation(id: conversation.id, tweets: conversation.tweets, username: widget.user.screenName!, showFullThread: false);
        },
        firstPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
          error: _pagingController.error[0],
          stackTrace: _pagingController.error[1],
          prefix: 'Unable to load the tweets',
          onRetry: () => _loadTweets(_pagingController.firstPageKey),
        ),
        newPageErrorIndicatorBuilder: (context) => FullPageErrorWidget(
          error: _pagingController.error[0],
          stackTrace: _pagingController.error[1],
          prefix: 'Unable to load the next page of tweets',
          onRetry: () => _loadTweets(_pagingController.nextPageKey),
        ),
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text('Couldn\'t find any tweets by this user!'),
          );
        },
      ),
    );
  }
}
