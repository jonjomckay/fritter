import 'dart:convert';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/saved/saved_tweet_model.dart';
import 'package:fritter/tweet/_video.dart';
import 'package:fritter/tweet/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  final ScrollController scrollController;
  
  const SavedScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> with AutomaticKeepAliveClientMixin<SavedScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<SavedTweetModel>().listSavedTweets();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<SavedTweetModel>();

    var prefs = PrefService.of(context, listen: false);

    return NestedScrollView(
      controller: widget.scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            title: Text(L10n.current.saved),
            actions: createCommonAppBarActions(context),
          )
        ];
      },
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<TweetContextState>(create: (_) => TweetContextState(prefs.get(optionTweetsHideSensitive))),
          ChangeNotifierProvider<VideoContextState>(create: (_) => VideoContextState(prefs.get(optionMediaDefaultMute))),
        ],
        child: ScopedBuilder<SavedTweetModel, Object, List<SavedTweet>>.transition(
          store: model,
          onError: (_, e) => FullPageErrorWidget(
            error: e,
            stackTrace: null,
            prefix: L10n.current.unable_to_load_the_tweets,
            onRetry: () => model.listSavedTweets(),
          ),
          onLoading: (_) => const Center(child: CircularProgressIndicator()),
          onState: (_, data) {
            if (data.isEmpty) {
              return Center(child: Text(L10n.of(context).you_have_not_saved_any_tweets_yet));
            }

            return ListView.builder(
              controller: widget.scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];

                var content = item.content;
                if (content == null) {
                  // The tweet is probably too big to fit inside the cursor and has been removed from the result set
                  return SavedTweetTooLarge(id: item.id);
                }

                var tweet = TweetWithCard.fromJson(jsonDecode(content));

                return TweetTile(key: Key(tweet.idStr!), tweet: tweet, clickable: true);
              },
            );
          },
        ),
      ),
    );
  }
}

class SavedTweetTooLarge extends StatelessWidget {
  final String id;

  const SavedTweetTooLarge({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.error, color: Colors.red),
              title: Text(L10n.current.oops_something_went_wrong),
              subtitle: Text(L10n.current.saved_tweet_too_large),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 64),
              child: AsyncButtonBuilder(
                successDuration: const Duration(days: 1),
                builder: (context, child, callback, buttonState) {
                  return TextButton(onPressed: callback, child: child);
                },
                onPressed: () async => Catcher.reportCheckedError(SavedTweetTooLargeException(id), null),
                child: Text(L10n.current.report),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class SavedTweetTooLargeException with SyntheticException implements Exception {
  final String id;

  SavedTweetTooLargeException(this.id);

  @override
  String toString() {
    return 'The saved tweet with the ID $id was too large';
  }
}
