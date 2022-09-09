import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/saved/saved_tweet_model.dart';
import 'package:fritter/tweet/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SavedScreen extends StatefulWidget {
  final ScrollController scrollController;
  
  const SavedScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SavedTweetModel>().listSavedTweets();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<SavedTweetModel>();

    return Scaffold(
      appBar: ScrollAppBar(
        controller: widget.scrollController,
        title: Text(L10n.current.saved),
        actions: createCommonAppBarActions(context),
      ),
      body: ChangeNotifierProvider<TweetContextState>(
        create: (context) => TweetContextState(PrefService.of(context, listen: false).get(optionTweetsHideSensitive)),
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
                var tweet = TweetWithCard.fromJson(jsonDecode(item.content));

                return TweetTile(key: Key(tweet.idStr!), tweet: tweet, clickable: true);
              },
            );
          },
        ),
      ),
    );
  }
}
