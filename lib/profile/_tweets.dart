import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet.dart';
import 'package:pagination_view/pagination_view.dart';

class ProfileTweets extends StatefulWidget {
  final User? user;
  final String username;
  final bool includeReplies;

  const ProfileTweets({Key? key, required this.user, required this.username, required this.includeReplies}) : super(key: key);

  @override
  _ProfileTweetsState createState() => _ProfileTweetsState();
}

class _ProfileTweetsState extends State<ProfileTweets> {
  final ScrollController _scrollController = ScrollController();
  String? _cursor;
  int _pageSize = 10;

  Future _onError(Object e, [StackTrace? stackTrace]) async {
    log('Unable to load the profile', error: e, stackTrace: stackTrace);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Something went wrong loading the tweets! The error was: $e'),
      duration: Duration(days: 1),
    ));
  }

  Future<List<TweetWithCard>> _loadTweets() async {
    try {
      var result = await Twitter.getTweets(
        widget.user!.idStr!,
        cursor: _cursor,
        count: _pageSize,
        includeReplies: widget.includeReplies
      );

      setState(() {
        this._cursor = result.cursorBottom;
      });

      return result.tweets;
    } catch (e, stackTrace) {
      _onError(e, stackTrace);
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PaginationView<TweetWithCard>(
      itemBuilder: (BuildContext context, TweetWithCard tweet, int index) {
        return TweetTile(currentUsername: widget.username, tweet: tweet, clickable: true);
      },
      paginationViewType: PaginationViewType.listView,
      pageFetch: (currentListSize) async {
        return _loadTweets();
      },
      onError: (dynamic error) {
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
      },
      onEmpty: Center(
        child: Text('Couldn\'t find any tweets from the last 7 days!'),
      ),
      bottomLoader: Center(
        child: CircularProgressIndicator(),
      ),
      initialLoader: Center(
        child: CircularProgressIndicator(),
      ),
      scrollController: _scrollController,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }
}
