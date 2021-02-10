import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/tweet.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';
import 'ui/tab_bar.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({Key key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreenBody(username: username),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  final String username;

  const ProfileScreenBody({Key key, this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final double _appBarHeight = 420.0;
  final double _appBarOffset = 340.0;
  ScrollController _controller;
  bool _silverCollapsed = false;
  String _title = '';

  bool _loading = true;
  Profile _profile = Profile(null, null, '', 'Loading...', null, null, '', 0, 0, 0, 0, List(), '', false, null, '');
  Iterable<Tweet> _tweets = List();
  String _error;

  StreamSubscription _sub;

  void onScroll() {
    if (_controller.offset > _appBarOffset && !_controller.position.outOfRange) {
      if (!_silverCollapsed) {
        setState(() {
          _title = _profile.fullName;
          _silverCollapsed = true;
        });
      }
    }
    if (_controller.offset <= _appBarOffset && !_controller.position.outOfRange) {
      if (_silverCollapsed) {
        setState(() {
          _silverCollapsed = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _controller.addListener(onScroll);

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

    var bannerImage = _profile.banner == null
        ? Container()
        : CachedNetworkImage(imageUrl: _profile.banner, fit: BoxFit.fitWidth, filterQuality: FilterQuality.high, alignment: Alignment.topCenter);

    Widget child;
    if (_error != null) {
      child = Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: Text(_error)),
      );
    } else {
      var tweets = _tweets.map((tweet) {
        return TweetTile(currentUsername: widget.username, tweet: tweet, clickable: true);
      }).toList();

      child = Column(children: tweets);
    }

    return Scaffold(
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            controller: _controller,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              if (_loading) {
                return [SliverToBoxAdapter(
                  child: Container(),
                )];
              }

              return [
                SliverAppBar(
                  expandedHeight: _appBarHeight,
                  backgroundColor: Theme.of(context).cardColor,
                  pinned: true,
                  bottom: TabBarWithFlexibleTabs(
                    child: TabBar(
                      tabs: [
                        Tab(child: Text('Tweets', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.subtitle2)),
                        Tab(child: Text('Tweets & Replies', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.subtitle2)),
                        Tab(child: Text('Media', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.subtitle2)),
                        Tab(child: Text('Likes', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.subtitle2)),
                      ],
                    ),
                  ),
                  title: AnimatedOpacity(
                    duration: Duration(milliseconds: 400),
                    opacity: _silverCollapsed ? 1 : 0,
                    child: Text(_title),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        bannerImage,
                        // const DecoratedBox(
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       begin: Alignment.bottomCenter,
                        //       end: Alignment.topCenter,
                        //       colors: <Color>[Color(0xDD000000), Color(0x80000000)],
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 104, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 106,
                                      child: _profile.avatar == null
                                        ? Container()
                                        : CachedNetworkImage(
                                          imageUrl: _profile.avatar,
                                          placeholder: (context, url) => const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 50,
                                          ),
                                          imageBuilder: (context, imageProvider) => CircleAvatar(
                                            radius: 53,
                                            backgroundColor: Colors.black54,
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: imageProvider,
                                            ),
                                          ),
                                        ),
                                    ),
                                    Expanded(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Tweets', style: Theme.of(context).textTheme.subtitle2.apply(
                                                        color: Theme.of(context).hintColor
                                                    )),
                                                    Text('${numberFormat.format(_profile.numberOfTweets)}', style: Theme.of(context).textTheme.headline6)
                                                  ]
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Following', style: Theme.of(context).textTheme.subtitle2.apply(
                                                        color: Theme.of(context).hintColor
                                                    )),
                                                    Text('${numberFormat.format(_profile.numberOfFollowing)}', style: Theme.of(context).textTheme.headline6)
                                                  ]
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Followers', style: Theme.of(context).textTheme.subtitle2.apply(
                                                        color: Theme.of(context).hintColor
                                                    )),
                                                    Text('${numberFormat.format(_profile.numberOfFollowers)}', style: Theme.of(context).textTheme.headline6)
                                                  ]
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Likes', style: Theme.of(context).textTheme.subtitle2.apply(
                                                        color: Theme.of(context).hintColor
                                                    )),
                                                    Text('${numberFormat.format(_profile.numberOfLikes)}', style: Theme.of(context).textTheme.headline6)
                                                  ]
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                child: Row(
                                  children: [
                                    Text(_profile.fullName, style: Theme.of(context).textTheme.headline6),
                                    SizedBox(width: 6),
                                    _profile.verified
                                        ? Icon(Icons.verified, color: Colors.blue, size: 20)
                                        : Container()
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                child: Text(_profile.username, style: Theme.of(context).textTheme.bodyText2.apply(
                                  color: Theme.of(context).hintColor
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.bodyText2,
                                      children: addLinksToText(context, _profile.biography)
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                child: _profile.location == null
                                    ? Container()
                                    : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.place, size: 12, color: Theme.of(context).hintColor),
                                    SizedBox(width: 4),
                                    Text(_profile.location, style: Theme.of(context).textTheme.bodyText2),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                child: _profile.websiteLink == null
                                    ? Container()
                                    : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.link, size: 12, color: Theme.of(context).hintColor),
                                    SizedBox(width: 4),
                                    InkWell(
                                      child: Text('${_profile.websiteLink.host}${_profile.websiteLink.path}', style: Theme.of(context).textTheme.bodyText1),
                                      onTap: () => launch(_profile.websiteLink.toString()),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                child: _profile.joinDate == null
                                    ? Container()
                                    : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today, size: 12, color: Theme.of(context).hintColor),
                                    SizedBox(width: 4),
                                    Text('Joined ${DateFormat('MMMM yyyy').format(_profile.joinDate)}', style: Theme.of(context).textTheme.bodyText2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: Container(
              child: LoadingStack(
                loading: _loading,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(child: child),
                    Center(child: Text('Coming soon')),
                    Center(child: Text('Coming soon')),
                    Center(child: Text('Coming soon')),
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
    if (_sub != null) {
      _sub.cancel();
    }
  }
}