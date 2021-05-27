import 'dart:async';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> _future;
  
  @override
  void initState() {
    super.initState();
    
    fetchProfile();
  }

  void fetchProfile() {
    setState(() {
      _future = Twitter.getProfile(widget.username);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilderWrapper<User>(
        future: _future,
        onReady: (user) => ProfileScreenBody(user: user),
        onError: (error, stackTrace) => FullPageErrorWidget(
          error: error,
          stackTrace: stackTrace,
          prefix: 'Unable to load the profile',
          onRetry: () => fetchProfile(),
        ),
      ),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  final User user;

  const ProfileScreenBody({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Make the app bar height the correct aspect ratio based on the header image size (1500x500)
    var deviceSize = MediaQuery.of(context).size;
    var appBarHeight = deviceSize.width * (500 / 1500);

    var profile = widget.user;
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
            ProfileTweets(user: profile, username: profile.screenName!, includeReplies: false),
            ProfileTweets(user: profile, username: profile.screenName!, includeReplies: true),
            comingSoon,
            comingSoon,
          ],
        ),
      ),
    );
  }
}