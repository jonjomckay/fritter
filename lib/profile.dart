import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/tweet.dart';
import 'package:intl/intl.dart';

import 'models.dart';

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

  bool _loading = true;
  Profile _profile = Profile(null, null, 'Loading...', null, 0, 0, 0, [], '', false);
  Iterable<Tweet> _tweets = [];
  String? _error;

  late StreamSubscription _sub;

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

      return Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong loading the profile! The error was: $e'),
        duration: Duration(days: 1),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => fetchProfile(username),
        ),
      ));
    };

    TwitterClient.getProfile(username).catchError(onError).then((profile) {
      setState(() {
        switch (profile.statusCode) {
          case 200:
            _profile = profile.profile;
            _tweets = profile.profile.tweets;
            break;
          case 403:
            _error = 'This profile is protected';
            break;
          default:
            _error = 'There was an unknown error loading the profile';
            break;
        }
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

    var banner = _profile.banner;
    var bannerImage = banner == null
        ? Container()
        : Image.network(banner, fit: BoxFit.cover, height: _appBarHeight);

    Widget child;
    if (_error != null) {
      child = Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: Text(_error!)),
      );
    } else {
      var tweets = _tweets.map((tweet) {
        return TweetTile(currentUsername: widget.username, tweet: tweet, clickable: true);
      }).toList();

      child = Column(children: tweets);
    }

    return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: _appBarHeight,
                pinned: true,
                bottom: TabBar(
                  tabs: [
                    Tab(child: Column(
                      children: [
                        Text('Tweets', style: Theme.of(context).primaryTextTheme.subtitle2),
                        Text('${numberFormat.format(_profile.numberOfTweets)}', style: Theme.of(context).primaryTextTheme.headline6),
                      ],
                    )),
                    Tab(child: Column(
                      children: [
                        Text('Following', style: Theme.of(context).primaryTextTheme.subtitle2),
                        Text('${numberFormat.format(_profile.numberOfFollowing)}', style: Theme.of(context).primaryTextTheme.headline6),
                      ],
                    )),
                    Tab(child: Column(
                      children: [
                        Text('Followers', style: Theme.of(context).primaryTextTheme.subtitle2),
                        Text('${numberFormat.format(_profile.numberOfFollowers)}', style: Theme.of(context).primaryTextTheme.headline6),
                      ],
                    )),
                  ],
                ),
                title: Text(_profile.fullName),
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
    if (_sub != null) {
      _sub.cancel();
    }
  }
}