import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/tweet/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeModel>();

    return Container(
      child: FutureBuilderWrapper<List<SavedTweet>>(
        future: model.listSavedTweets(),
        onError: (error, stackTrace) => FullPageErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to find your saved tweets.'),
        onReady: (data) {
          if (data.isEmpty) {
            return Center(child: Text("You haven't saved any tweets yet!"));
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
      )
    );
  }
}
