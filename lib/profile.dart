import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/tweet.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

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

  bool _loading = true;
  User? _profile;
  List<Tweet> _tweets = [];
  String? _error;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    fetchProfile(widget.id, widget.username);
  }

  void fetchProfile(String? id, String username) {
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
          onPressed: () => fetchProfile(id, username),
        ),
      ));
    };

    // If we're given an ID, we can perform both requests at the same time, otherwise we need to load the profile first to get the ID
    if (id == null) {
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
    } else {
      var task1 = Twitter.getProfile(username).catchError(onError);
      var task2 = Twitter.getTweets(id).catchError(onError);

      Future.wait([task1, task2]).then((value) {
        var profile = value[0] as User;
        var tweets = value[1] as List<Tweet>;

        setState(() {
          _profile = profile;
          _tweets = tweets;
          _loading = false;
        });
      }).whenComplete(() => setState(() {
        _loading = false;
      }));
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
                actions: [
                  FollowButton(user: profile)
                ],
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

class FollowButton extends StatefulWidget {
  final User user;

  const FollowButton({Key? key, required this.user}) : super(key: key);
  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool? _followed;

  @override
  void initState() {
    super.initState();

    fetchFollowed();
  }

  Future fetchFollowed() {
    return isFollowed(int.parse(widget.user.idStr!))
        .then((value) => setState(() {
          this._followed = value;
        }));
  }

  Future<bool> isFollowed(int id) async {
    Database database = await Repository.open();

    var result = await database.rawQuery('SELECT EXISTS (SELECT 1 FROM following WHERE id = ?)', [id]);
    if (result.isEmpty) {
      return false;
    }

    return result.first.values.first == 1
      ? true
      : false;
  }

  @override
  Widget build(BuildContext context) {
    var id = int.parse(widget.user.idStr!);

    var followed = _followed;
    if (followed == null) {
      return Center(child: CircularProgressIndicator());
    }

    return MaterialButton(
        child: followed
            ? Text('Unfollow')
            : Text('Follow'),
        onPressed: () async {
          Database database = await Repository.open();

          if (followed) {
            await database.delete('following', where: 'id = ?', whereArgs: [id]);
          } else {
            await database.insert('following', {
              'id': id,
              'screen_name': widget.user.screenName,
              'name': widget.user.name,
              'profile_image_url_https': widget.user.profileImageUrlHttps
            });
          }

          await fetchFollowed();
        }
    );
  }
}
