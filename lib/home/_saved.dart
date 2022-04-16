import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/tweet/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeModel>();

    return FutureBuilderWrapper<List<SavedTweet>>(
      future: model.listSavedTweets(),
      onError: (error, stackTrace) => FullPageErrorWidget(
        error: error,
        stackTrace: stackTrace,
        prefix: L10n.of(context).unable_to_find_your_saved_tweets,
      ),
      onReady: (data) {
        if (data.isEmpty) {
          return Center(child: Text(L10n.of(context).you_have_not_saved_any_tweets_yet));
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            var tweet = TweetWithCard.fromJson(jsonDecode(item.content));

            return TweetTile(tweet: tweet, clickable: true);
          },
        );
      },
    );
  }
}
