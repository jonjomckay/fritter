import 'dart:async';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/profile/_follows.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';
import 'package:intl/intl.dart';
import 'package:measured_size/measured_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fritter/generated/l10n.dart';

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
          prefix: L10n.of(context).unable_to_load_the_profile,
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

  double descriptionHeight = 0;
  double metadataHeight = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
  }

  List<InlineSpan> _addLinksToText(BuildContext context, String content) {
    List<InlineSpan> contentWidgets = [];

    // Split the string by any mentions or hashtags, and turn those into links
    content.splitMapJoin(RegExp(r'(#|(?<=\W|^)@)\w+'), onMatch: (match) {
      var full = match.group(0);
      var type = match.group(1);
      if (type == null || full == null) {
        return '';
      }

      var onTap = () async {};
      if (type == '#') {
        onTap = () async {
          await showSearch(context: context, delegate: TweetSearchDelegate(initialTab: 1), query: full);
        };
      }

      if (type == '@') {
        onTap = () async {
          Navigator.pushNamed(context, routeProfile, arguments: full.substring(1));
        };
      }

      contentWidgets.add(TextSpan(
          text: full,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          recognizer: TapGestureRecognizer()..onTap = onTap));

      return type;
    }, onNonMatch: (text) {
      contentWidgets.add(TextSpan(text: text));

      return text;
    });

    return contentWidgets;
  }

  @override
  Widget build(BuildContext context) {
    // Make the app bar height the correct aspect ratio based on the header image size (1500x500)
    var mediaQuery = MediaQuery.of(context);
    var deviceSize = mediaQuery.size;
    var bannerHeight = deviceSize.width * (500 / 1500);
    var avatarHeight = 80;

    var profileImageTop = bannerHeight + 16 - 36 - mediaQuery.padding.top;
    var profileStuffTop = bannerHeight;

    var theme = Theme.of(context);

    var profile = widget.user;
    var banner = profile.profileBannerUrl;
    var bannerImage = banner == null
        ? Container(height: bannerHeight, color: Colors.white)
        : ExtendedImage.network(banner, fit: BoxFit.fitWidth, height: bannerHeight);

    // The height of the app bar should be all the inner components, plus any margins
    var appBarHeight = profileStuffTop + avatarHeight + metadataHeight + 48 + descriptionHeight;

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
                  FollowButton(
                    id: profile.idStr!,
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
                    Tab(
                      child: Text(
                        L10n.of(context).tweets,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        L10n.of(context).tweets_and_replies,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        L10n.of(context).media,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        L10n.of(context).following,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        L10n.of(context).followers,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white),
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Container(alignment: Alignment.topCenter, child: bannerImage),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[Color(0xDD000000), Color(0x80000000)],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(16, profileStuffTop, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        children: [
                                          Text(profile.name!,
                                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                          if (profile.verified ?? false) const SizedBox(width: 6),
                                          if (profile.verified ?? false)
                                            const Icon(Icons.verified, size: 24, color: Colors.blue)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Text('@${(profile.screenName!)}',
                                          style: TextStyle(color: theme.primaryTextTheme.caption!.color)),
                                    ),
                                    if (profile.description != null && profile.description!.isNotEmpty)
                                      MeasuredSize(
                                        onChange: (size) {
                                          setState(() {
                                            descriptionHeight = size.height;
                                          });
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(bottom: 4),
                                            child: RichText(
                                                maxLines: 3,
                                                text: TextSpan(
                                                    style: const TextStyle(height: 1.4),
                                                    children: _addLinksToText(context, profile.description!)))),
                                      ),
                                    MeasuredSize(
                                      onChange: (size) {
                                        setState(() {
                                          metadataHeight = size.height;
                                        });
                                      },
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            if (profile.location != null && profile.location!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.place, size: 12, color: Colors.white),
                                                    const SizedBox(width: 4),
                                                    Text(profile.location!),
                                                  ],
                                                ),
                                              ),
                                            if (profile.url != null && profile.url!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.link, size: 12, color: Colors.white),
                                                    const SizedBox(width: 4),
                                                    Builder(builder: (context) {
                                                      var url = profile.entities?.url?.urls
                                                          ?.firstWhere((element) => element.url == profile.url);

                                                      if (url == null) {
                                                        return Container();
                                                      }

                                                      return InkWell(
                                                        child: Text(url.displayUrl!,
                                                            style: const TextStyle(color: Colors.blue)),
                                                        onTap: () => launch(url.expandedUrl!),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            if (profile.createdAt != null)
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.calendar_today, size: 12, color: Colors.white),
                                                    const SizedBox(width: 4),
                                                    Text(L10n.of(context)
                                                        .joined(DateFormat('MMMM yyyy').format(profile.createdAt!))),
                                                  ],
                                                ),
                                              ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.fromLTRB(16, profileImageTop, 16, 16),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: createUserAvatar(profile.profileImageUrlHttps, 72).image,
                            radius: 48,
                          ),
                        ),
                      )
                    ]),
                  ),
                )))
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
