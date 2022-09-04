import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/profile/_follows.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/profile/profile_model.dart';
import 'package:fritter/search/search.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/physics.dart';
import 'package:fritter/user.dart';
import 'package:fritter/utils/urls.dart';
import 'package:intl/intl.dart';
import 'package:measure_size/measure_size.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;

    return Provider(
      create: (context) => ProfileModel()..loadProfile(username),
      child: _ProfileScreen(username: username)
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  final String username;

  const _ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProfileModel, Object, Profile>.transition(
        store: context.read<ProfileModel>(),
        onError: (_, error) => FullPageErrorWidget(
          error: error,
          stackTrace: null,
          prefix: L10n.of(context).unable_to_load_the_profile,
          onRetry: () => context.read<ProfileModel>().loadProfile(username),
        ),
        onLoading: (_) => const Center(child: CircularProgressIndicator()),
        onState: (_, state) => ProfileScreenBody(profile: state),
      ),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  final Profile profile;

  const ProfileScreenBody({Key? key, required this.profile}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> with TickerProviderStateMixin {
  static const defaultHeight = 256.12345;

  late TabController _tabController;

  double descriptionHeight = defaultHeight;
  double metadataHeight = defaultHeight;

  bool descriptionResized = false;
  bool metadataResized = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);

    var description = widget.profile.user.description;
    if (description == null || description.isEmpty) {
      descriptionHeight = 0;
      descriptionResized = true;
    }
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
          Navigator.pushNamed(context, routeSearch,
            arguments: SearchArguments(1, focusInputOnOpen: false, query: full));
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
    // TODO: This shouldn't happen before the profile is loaded
    var user = widget.profile.user;
    if (user.idStr == null) {
      return Container();
    }

    // Make the app bar height the correct aspect ratio based on the header image size (1500x500)
    var mediaQuery = MediaQuery.of(context);
    var deviceSize = mediaQuery.size;
    var bannerHeight = deviceSize.width * (500 / 1500);
    var avatarHeight = 80;

    var profileImageTop = bannerHeight + 16 - 36 - mediaQuery.padding.top;
    var profileStuffTop = bannerHeight + 36;

    var theme = Theme.of(context);

    var banner = user.profileBannerUrl;
    var bannerImage = banner == null
        ? Container(height: bannerHeight, color: Colors.white)
        : ExtendedImage.network(banner, fit: BoxFit.fitWidth, height: bannerHeight);

    // The height of the app bar should be all the inner components, plus any margins
    var appBarHeight = profileStuffTop + avatarHeight + metadataHeight + 8 + descriptionHeight;

    return Scaffold(
      body: Stack(children: [
        NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  expandedHeight: appBarHeight,
                  floating: true,
                  pinned: true,
                  snap: false,
                  forceElevated: innerBoxIsScrolled,
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
                        top: false,
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
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(user.name!,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                              ),
                                              if (user.verified ?? false) const SizedBox(width: 6),
                                              if (user.verified ?? false)
                                                const Icon(Icons.verified, size: 24, color: Colors.blue)
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 8),
                                            child: Text('@${(user.screenName!)}',
                                                style: const TextStyle(fontSize: 14, color: Colors.white70)),
                                          ),
                                          if (user.description != null && user.description!.isNotEmpty)
                                            MeasureSize(
                                              onChange: (size) {
                                                setState(() {
                                                  descriptionHeight = size.height;
                                                  descriptionResized = true;
                                                });
                                              },
                                              child: Container(
                                                  margin: const EdgeInsets.only(bottom: 8),
                                                  child: RichText(
                                                      maxLines: 3,
                                                      text: TextSpan(
                                                          style: const TextStyle(height: 1.4),
                                                          children: _addLinksToText(context, user.description!)))),
                                            ),
                                          MeasureSize(
                                            onChange: (size) {
                                              setState(() {
                                                metadataHeight = size.height;
                                                metadataResized = true;
                                              });
                                            },
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  if (user.location != null && user.location!.isNotEmpty)
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.place, size: 12, color: Colors.white),
                                                          const SizedBox(width: 4),
                                                          Text(user.location!, style: const TextStyle(fontSize: 13)),
                                                        ],
                                                      ),
                                                    ),
                                                  if (user.url != null && user.url!.isNotEmpty)
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.link, size: 12, color: Colors.white),
                                                          const SizedBox(width: 4),
                                                          Builder(builder: (context) {
                                                            var url = user.entities?.url?.urls
                                                                ?.firstWhere((element) => element.url == user.url);

                                                          if (url == null) {
                                                            return Container();
                                                          }

                                                          return InkWell(
                                                            child: Text(url.displayUrl!,
                                                                style: const TextStyle(color: Colors.blue, fontSize: 13)),
                                                            onTap: () => openUri(url.expandedUrl!),
                                                          );
                                                        }),
                                                      ],
                                                    )),
                                                  if (user.createdAt != null)
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.calendar_today, size: 12, color: Colors.white),
                                                          const SizedBox(width: 4),
                                                          Text(L10n.of(context)
                                                              .joined(DateFormat('MMMM yyyy').format(user.createdAt!)),
                                                              style: const TextStyle(fontSize: 13)
                                                          ),
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
                              child: FollowButton(user: user),
                              margin: EdgeInsets.fromLTRB(128, profileImageTop + 64, 16, 16),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(16, profileImageTop, 16, 16),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: UserAvatar(uri: user.profileImageUrlHttps, size: 96),
                              ),
                            )
                          ]),
                        ),
                      )))
            ];
          },
          body: TabBarView(
            controller: _tabController,
            physics: const LessSensitiveScrollPhysics(),
            children: [
              ProfileTweets(user: user, type: 'profile', includeReplies: false, pinnedTweets: widget.profile.pinnedTweets),
              ProfileTweets(user: user, type: 'profile', includeReplies: true, pinnedTweets: widget.profile.pinnedTweets),
              ProfileTweets(user: user, type: 'media', includeReplies: false, pinnedTweets: const []),
              ProfileFollows(user: user, type: 'following'),
              ProfileFollows(user: user, type: 'followers'),
            ],
          ),
        ),

        // If we haven't resized the description widget yet, display an overlay container so we don't see the resize
        // TODO: This flickers
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: descriptionResized == true && metadataResized == true
              ? Container(key: const Key('loaded'))
              : Container(
                  key: const Key('waiting'),
                  height: double.infinity,
                  color: theme.backgroundColor,
                ),
        )
      ]),
    );
  }
}
