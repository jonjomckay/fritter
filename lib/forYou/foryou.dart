import 'package:extended_image/extended_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/profile/_filters.dart';
import 'package:fritter/profile/_follows.dart';
import 'package:fritter/profile/_saved.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/profile/profile_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/physics.dart';
import 'package:fritter/user.dart';
import 'package:fritter/utils/urls.dart';
import 'package:intl/intl.dart';
import 'package:measure_size/measure_size.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import '../home/_saved.dart';
import '../settings/_account.dart';
import '_tweets.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ForYouScreenBody());
  }
}

class ForYouScreenBody extends StatefulWidget {
  const ForYouScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForYouScreenBodyState();
}

class _ForYouScreenBodyState extends State<ForYouScreenBody> with TickerProviderStateMixin {
  final GlobalKey<NestedScrollViewState> nestedScrollViewKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  late TabController _tabController;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var nestedScrollViewState = nestedScrollViewKey.currentState;
      if (nestedScrollViewState == null) {
        return;
      }

      nestedScrollViewState.innerController.addListener(_listen);
    });

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    nestedScrollViewKey.currentState?.innerController.removeListener(_listen);

    super.dispose();
  }

  void _listen() {
    var nestedScrollViewState = nestedScrollViewKey.currentState;
    if (nestedScrollViewState == null) {
      return;
    }

    if (!nestedScrollViewState.innerController.hasClients) {
      return;
    }

    // Show the "scroll to top" button if we scroll down a bit, and hide it if we go back above
    if (nestedScrollViewState.innerController.positions.any((element) => element.pixels >= 400)) {
      if (!_showBackToTopButton) {
        setState(() {
          _showBackToTopButton = true;
        });
      }
    } else {
      if (_showBackToTopButton) {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    }
  }

  void _scrollToTop() {
    // We scroll the outer controller (the whole nested scroll view and children) to the top
    // TODO: No animation due to Flutter crashing on huge lists (https://github.com/flutter/flutter/issues/52207) (#607)
    nestedScrollViewKey.currentState?.outerController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context, listen: false);
    UserWithExtra user = UserWithExtra();
    user.idStr = "1";
    user.possiblySensitive = false;
    user.screenName = "ForYou";
    return Scaffold(
        body: Stack(children: [
      ExtendedNestedScrollView(
        key: nestedScrollViewKey,
        onlyOneScrollInBody: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text( L10n.of(context).foryou),
              // This is the title in the app bar.
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
                      L10n.of(context).saved,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                      child: Text(
                    L10n.of(context).tweetFilters,
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          physics: const LessSensitiveScrollPhysics(),
          children: [
            MultiProvider(
                providers: [
                  ChangeNotifierProvider<TweetContextState>(
                      create: (_) => TweetContextState(prefs.get(optionTweetsHideSensitive))),
                  Provider(create: (context) => ProfileModel()..loadProfileByScreenName("KverulantOrg")),
                  //ChangeNotifierProvider<TweetContextState>(create: (_) => TweetContextState(PrefService.of(context).get(optionTweetsHideSensitive)))
                ],
                builder: (context, child) {
                  return Scaffold(
                    body: ForYouTweets(
                        user: user,
                        type: 'profile',
                        includeReplies: false,
                        pinnedTweets: [],
                        pref: PrefService.of(context)),
                  );
                }),
            SavedScreen(scrollController: scrollController),
            Filters(user: user),
            // Filters(user: null),
          ],
        ),
      ),

      // If we haven't resized the description widget yet, display an overlay container so we don't see the resize
      // TODO: This flickers
      //   AnimatedSwitcher(
      //     duration: const Duration(milliseconds: 150),
      //     child: descriptionResized == true && metadataResized == true
      //         ? Container(key: const Key('loaded'))
      //         : Container(
      //       key: const Key('waiting'),
      //       height: double.infinity,
      //       color: theme.backgroundColor,
      //     ),
      //   )
      // ]),
      // floatingActionButton: _showBackToTopButton == false
      //     ? null
      //     : FloatingActionButton(
      //   onPressed: _scrollToTop,
      //   child: const Icon(Icons.arrow_upward),
      // ),
    ]));
  }
}

class TweetContextState extends ChangeNotifier {
  bool hideSensitive;

  TweetContextState(this.hideSensitive);

  void setHideSensitive(bool value) {
    hideSensitive = value;
    notifyListeners();
  }
}
