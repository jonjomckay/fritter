import 'dart:async';
import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/user.dart';
import 'package:http/http.dart';

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

class _ProfileScreenBodyState extends State<ProfileScreenBody> with TickerProviderStateMixin {
  late TabController _tabController;

  User? _profile;
  dynamic? _error;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    fetchProfile(widget.id, widget.username);
  }

  Future onError(Object e, [StackTrace? stackTrace]) async {
    log('Unable to load the profile', error: e, stackTrace: stackTrace);

    var error = e is Response
      ? e.body
      : e;

    setState(() {
      _error = error;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Something went wrong loading the profile!'),
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
        _error = null;
        _profile = profile;
      });
    });
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
    // Make the app bar height the correct aspect ratio based on the header image size (1500x500)
    var deviceSize = MediaQuery.of(context).size;
    var appBarHeight = deviceSize.width * (500 / 1500);

    var error = _error;
    if (error != null) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Oops! Something went wrong 🥲', style: TextStyle(
                fontSize: 18
            )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text('$error', textAlign: TextAlign.center, style: TextStyle(
                  color: Theme.of(context).hintColor
              )),
            )
          ],
        ),
      );
    }

    var profile = _profile;
    if (profile == null) {
      return Center(child: CircularProgressIndicator());
    }

    var banner = profile.profileBannerUrl;
    var bannerImage = banner == null
        ? Container()
        : ExtendedImage.network(banner, fit: BoxFit.cover, height: appBarHeight, cache: true);

    var comingSoon = Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('🙈', style: TextStyle(
            fontSize: 32
        )),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Text('Coming soon!', style: TextStyle(
              color: Theme.of(context).hintColor
          )),
        )
      ],
    ));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: appBarHeight,
              floating: true,
              pinned: true,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              actions: [
                FollowButton(id: profile.idStr!,
                    name: profile.name!,
                    screenName: profile.screenName!,
                    imageUri: profile.profileImageUrlHttps)
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Tweets', textAlign: TextAlign.center)),
                  Tab(child: Text('Tweets & Replies', textAlign: TextAlign.center)),
                  Tab(child: Text('Following', textAlign: TextAlign.center)),
                  Tab(child: Text('Followers', textAlign: TextAlign.center)),
                ],
              ),
              title: Row(
                children: [
                  Text(profile.name!),
                  if (profile.verified ?? false)
                    SizedBox(width: 6),
                  if (profile.verified ?? false)
                    Icon(Icons.verified, size: 24, color: Colors.white)
                ],
              ),
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
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ProfileTweets(user: _profile, username: widget.username, includeReplies: false),
            ProfileTweets(user: _profile, username: widget.username, includeReplies: true),
            comingSoon,
            comingSoon,
          ],
        ),
      ),
    );
  }
}