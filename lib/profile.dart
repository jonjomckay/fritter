import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/tweet.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreenBody(username: username),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  final String username;

  const ProfileScreenBody({Key? key, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final double _appBarHeight = 256.0;
  final _scrollController = ScrollController();

  bool _loading = true;
  User? _profile;
  List<Tweet> _tweets = [];
  String? _error;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    fetchProfile(widget.username);
  }

  void fetchProfile(String username) {
    setState(() {
      _loading = true;
    });

    var onError = (e, stackTrace) {
      log('Unable to load the profile', error: e, stackTrace: stackTrace);

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong loading the profile! The error was: $e'),
        duration: Duration(days: 1),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => fetchProfile(username),
        ),
      ));
    };

    Twitter.getProfile(username).catchError(onError).then((profile) {
      Twitter.getTweets(profile.idStr!).catchError(onError).then((tweets) {
        setState(() {
          _profile = profile;
          _tweets = tweets;
          _loading = false;
        });
      });
    }).whenComplete(() => setState(() {
      _loading = false;
    }));
  }

  @override
  void didUpdateWidget(ProfileScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.username != widget.username) {
      fetchProfile(widget.username);
    }
  }

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat.compact();

    Widget child;

    var profile = _profile;
    if (profile == null) {
      return Center(child: CircularProgressIndicator());
    }

    var banner = profile.profileBannerUrl;
    var bannerImage = banner == null
        ? Container()
        : CachedNetworkImage(imageUrl: banner, fit: BoxFit.cover, height: _appBarHeight);

    if (_error != null) {
      child = Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: Text(_error!)),
      );
    } else {
      child = Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: _tweets.length,
          itemBuilder: (context, index) {
            var tweet = _tweets[index];

            return TweetTile(currentUsername: widget.username, tweet: tweet, clickable: true);
          },
        ),
      );
    }

    return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: _appBarHeight,
                pinned: true,
                bottom: TabBar(
                  tabs: [
                    Tab(child: Column(
                      children: [
                        Text('Tweets', style: Theme.of(context).primaryTextTheme.subtitle2),
                        Text('${numberFormat.format(profile.statusesCount)}', style: Theme.of(context).primaryTextTheme.headline6),
                      ],
                    )),
                    Tab(child: Column(
                      children: [
                        Text('Following', style: Theme.of(context).primaryTextTheme.subtitle2),
                        Text('${numberFormat.format(profile.friendsCount)}', style: Theme.of(context).primaryTextTheme.headline6),
                      ],
                    )),
                    Tab(child: Column(
                      children: [
                        Text('Followers', style: Theme.of(context).primaryTextTheme.subtitle2),
                        Text('${numberFormat.format(profile.followersCount)}', style: Theme.of(context).primaryTextTheme.headline6),
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
              SliverToBoxAdapter(
                  child: LoadingStack(
                    loading: _loading,
                    child: child,
                  )
              ),
            ],
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