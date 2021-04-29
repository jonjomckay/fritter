import 'dart:async';
import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet.dart';
import 'package:intl/intl.dart';
import 'package:pagination_view/pagination_view.dart';

import 'user.dart';

class ProfileScreen extends StatelessWidget {
  final String? id;
  final String username;

  const ProfileScreen({Key? key, this.id, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreenBody(id: id, username: username),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  final String? id;
  final String username;

  const ProfileScreenBody({Key? key, this.id, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final double _appBarHeight = 256.0;
  final _scrollController = ScrollController();

  User? _profile;
  String? _cursor;
  int _pageSize = 10;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    fetchProfile(widget.id, widget.username);
  }

  Future onError(Object e, [StackTrace? stackTrace]) async {
    log('Unable to load the profile', error: e, stackTrace: stackTrace);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Something went wrong loading the profile! The error was: $e'),
      duration: Duration(days: 1),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () => fetchProfile(widget.id, widget.username),
      ),
    ));
  }

  void fetchProfile(String? id, String username) {
    Twitter.getProfile(username).catchError(onError).then((profile) {
      setState(() {
        _profile = profile;
      });
    });
  }

  Future<List<TweetWithCard>> _loadTweets() async {
    try {
      var result = await Twitter.getTweets(_profile!.idStr!, cursor: _cursor, count: _pageSize);

      setState(() {
        this._cursor = result.cursorBottom;
      });

      return result.tweets;
    } catch (e, stackTrace) {
      onError(e, stackTrace);
      return Future.error(e);
    }
  }

  @override
  void didUpdateWidget(ProfileScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.username != widget.username) {
      fetchProfile(widget.id, widget.username);
    }
  }

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat.compact();

    var profile = _profile;
    if (profile == null) {
      return Center(child: CircularProgressIndicator());
    }

    var banner = profile.profileBannerUrl;
    var bannerImage = banner == null
        ? Container()
        : ExtendedImage.network(banner, fit: BoxFit.cover, height: _appBarHeight, cache: true);

    return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: PaginationView<TweetWithCard>(
            itemBuilder: (BuildContext context, TweetWithCard tweet, int index) {
              return TweetTile(currentUsername: widget.username, tweet: tweet, clickable: true);
            },
            paginationViewType: PaginationViewType.listView,
            pageFetch: (currentListSize) async {
              return _loadTweets();
            },
            onError: (dynamic error) {
              onError(error);

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
            header: SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              actions: [
                FollowButton(id: profile.idStr!,
                    name: profile.name!,
                    screenName: profile.screenName!,
                    imageUri: profile.profileImageUrlHttps)
              ],
              bottom: TabBar(
                tabs: [
                  Tab(child: Column(
                    children: [
                      Text('Tweets', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .subtitle2),
                      Text('${numberFormat.format(profile.statusesCount)}', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .headline6),
                    ],
                  )),
                  Tab(child: Column(
                    children: [
                      Text('Following', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .subtitle2),
                      Text('${numberFormat.format(profile.friendsCount)}', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .headline6),
                    ],
                  )),
                  Tab(child: Column(
                    children: [
                      Text('Followers', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .subtitle2),
                      Text('${numberFormat.format(profile.followersCount)}', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .headline6),
                    ],
                  )),
                ],
              ),
              title: Text(profile.name!),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    bannerImage,
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[Color(0xBB000000), Color(0x50000000)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }
}