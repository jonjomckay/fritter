import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/tweet.dart';
import 'package:provider/provider.dart';

class SavedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeModel>();

    return Container(
      child: FutureBuilder<List<TweetWithCard>>(
        future: model.listSavedTweets(),
        builder: (context, snapshot) {
          var error = snapshot.error;
          if (error != null) {
            log('Unable to list saved tweets', error: error, stackTrace: snapshot.stackTrace);
            return Center(child: Text(error.toString()));
          }

          var data = snapshot.data;
          if (data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return TweetTile(tweet: data[index], clickable: true);
            },
          );
        },
      )
    );
  }
}
