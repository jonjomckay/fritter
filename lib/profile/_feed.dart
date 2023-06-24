import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/profile/profile_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class ProfileFeedScreen extends StatelessWidget {
  final String? screenName;

  const ProfileFeedScreen({Key? key, this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        return ProfileModel()..loadProfileByScreenName(screenName!);
      },
      child: _ProfileFeedScreen(screenName: screenName),
    );
  }
}

class _ProfileFeedScreen extends StatelessWidget {
  final String? screenName;

  const _ProfileFeedScreen({Key? key, this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('@$screenName'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, routeProfile,
                  arguments: ProfileScreenArguments.fromScreenName(screenName!)),
              icon: const Icon(Icons.open_in_new)),
          ...createCommonAppBarActions(context)
        ],
      ),
      body: ScopedBuilder<ProfileModel, Object, Profile>.transition(
        store: context.read<ProfileModel>(),
        onError: (_, error) => FullPageErrorWidget(
          error: error,
          stackTrace: null,
          prefix: L10n.of(context).unable_to_load_the_profile,
          onRetry: () {
            return context.read<ProfileModel>().loadProfileByScreenName(screenName!);
          },
        ),
        onLoading: (_) => const Center(child: CircularProgressIndicator()),
        onState: (_, state) => ProfileFeedScreenBody(profile: state),
      ),
    );
  }
}

class ProfileFeedScreenBody extends StatefulWidget {
  final Profile profile;

  const ProfileFeedScreenBody({Key? key, required this.profile}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileFeedScreenBodyState();
}

class _ProfileFeedScreenBodyState extends State<ProfileFeedScreenBody> with TickerProviderStateMixin {
  final GlobalKey<NestedScrollViewState> nestedScrollViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: This shouldn't happen before the profile is loaded
    var user = widget.profile.user;
    if (user.idStr == null) {
      return Container();
    }

    var prefs = PrefService.of(context, listen: false);
    return Scaffold(
      body: ExtendedNestedScrollView(
        key: nestedScrollViewKey,
        onlyOneScrollInBody: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [];
        },
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<TweetContextState>(
                create: (_) => TweetContextState(prefs.get(optionTweetsHideSensitive)))
          ],
          child: ProfileTweets(
              user: user,
              type: 'profile',
              includeReplies: false,
              pinnedTweets: widget.profile.pinnedTweets,
              fromFeed: true),
        ),
      ),
    );
  }
}
