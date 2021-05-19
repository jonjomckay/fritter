import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileTweets extends StatefulWidget {
  final User? user;
  final String username;
  final bool includeReplies;

  const ProfileTweets({Key? key, required this.user, required this.username, required this.includeReplies}) : super(key: key);

  @override
  _ProfileTweetsState createState() => _ProfileTweetsState();
}

class _ProfileTweetsState extends State<ProfileTweets> {
  late PagingController<String?, TweetWithCard> _pagingController;

  int _pageSize = 10;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _loadTweets(cursor);
    });
  }

  Future _onError(Object? e, [StackTrace? stackTrace]) async {
    log('Unable to load the profile', error: e, stackTrace: stackTrace);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Something went wrong loading the tweets! The error was: $e'),
      duration: Duration(days: 1),
    ));
  }

  Future _loadTweets(String? cursor) async {
    try {
      var result = await Twitter.getTweets(
        widget.user!.idStr!,
        cursor: cursor,
        count: _pageSize,
        includeReplies: widget.includeReplies
      );

      _pagingController.appendPage(result.tweets, result.cursorBottom);
    } catch (e) {
      _pagingController.error = e;
    }
  }

  Widget _createErrorWidget() {
    var error = _pagingController.error;

    _onError(error);

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Unable to load the profile 😢', style: TextStyle(
                  fontSize: 22
              )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(error.toString(), style: TextStyle(
                    color: Theme.of(context).hintColor
                )),
              )
            ])
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<String?, TweetWithCard>(
      padding: EdgeInsets.zero,
      pagingController: _pagingController,
      addAutomaticKeepAlives: false,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, tweet, index) {
          return TweetTile(currentUsername: widget.username, tweet: tweet, clickable: true);
        },
        firstPageErrorIndicatorBuilder: (context) => _createErrorWidget(),
        newPageErrorIndicatorBuilder: (context) => _createErrorWidget(),
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text('Couldn\'t find any tweets from the last 7 days!'),
          );
        },
      ),
    );
  }
}
