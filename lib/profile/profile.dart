import 'dart:async';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/profile/_follows.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;

    return _ProfileScreen(username: username);
  }
}


class _ProfileScreen extends StatefulWidget {
  final String username;

  const _ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen> {
  static final log = Logger('_ProfileScreenState');

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

    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var appBarHeight = 240.0;

    var profile = widget.user;
    var banner = profile.profileBannerUrl;
    var bannerImage = banner == null
        ? Container()
        : ExtendedImage.network(banner, fit: BoxFit.cover, height: appBarHeight, cache: true);

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
                  imageUri: profile.profileImageUrlHttps,
                  verified: profile.verified!,
                )
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Tweets', textAlign: TextAlign.center)),
                  Tab(child: Text('Tweets & Replies', textAlign: TextAlign.center)),
                  Tab(child: Text('Media', textAlign: TextAlign.center)),
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
                          colors: <Color>[Color(0xDD000000), Color(0x80000000)],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 72, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: new Border.all(
                                      color: Colors.black12,
                                      width: 4.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(64),
                                    child: UserAvatar(
                                      uri: profile.profileImageUrlHttps,
                                      size: 72,
                                    ),
                                  )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (profile.location != null && profile.location!.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.place, size: 12, color: Theme.of(context).hintColor),
                                            SizedBox(width: 4),
                                            Text(profile.location!, style: Theme.of(context).textTheme.bodyText2),
                                          ],
                                        ),
                                      ),
                                    if (profile.url != null && profile.url!.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.link, size: 12, color: Theme.of(context).hintColor),
                                            SizedBox(width: 4),
                                            Builder(builder: (context) {
                                              var url = profile.entities?.url?.urls
                                                  ?.firstWhere((element) => element.url == profile.url);

                                              if (url == null) {
                                                return Container();
                                              }

                                              return InkWell(
                                                child: Text('${url.displayUrl!}', style: Theme.of(context).textTheme.bodyText2),
                                                onTap: () => launch(url.expandedUrl!),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    if (profile.createdAt != null)
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today, size: 12, color: Theme.of(context).hintColor),
                                            SizedBox(width: 4),
                                            Text('Joined ${DateFormat('MMMM yyyy').format(profile.createdAt!)}', style: Theme.of(context).textTheme.bodyText2),
                                          ],
                                        ),
                                      ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText2,
                                text: profile.description!,
                                // children: addLinksToText(context, _profile.biography)
                              )
                            )
                          )
                        ],
                      )
                  ),
                  ]
                )
              )
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ProfileTweets(user: profile, type: 'profile', includeReplies: false),
            ProfileTweets(user: profile, type: 'profile', includeReplies: true),
            ProfileTweets(user: profile, type: 'media', includeReplies: false),
            ProfileFollows(user: profile, type: 'following'),
            ProfileFollows(user: profile, type: 'followers'),
          ],
        ),
      ),
    );
  }
}