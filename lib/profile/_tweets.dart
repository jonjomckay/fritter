import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet/conversation.dart';
import 'package:fritter/ui/errors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  int _pageSize = 20;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _loadTweets(cursor);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
        itemBuilder: (context, chain, index) {
          return TweetConversation(id: chain.id, tweets: chain.tweets, username: widget.user.screenName!, isPinned: chain.isPinned);
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
