import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';

import 'database.dart';
import 'database/entities.dart';

class HomeModel extends ChangeNotifier {
  Future<List<Trends>> loadTrends() async {
    return Twitter.getTrends();
  }

  Future<List<Following>> listFollowing() async {
    var database = await Repository.open();

    return (await database.query('following', orderBy: 'screen_name'))
        .map((e) => Following.fromMap(e))
        .toList(growable: false);
  }

  Future refresh() async {
    notifyListeners();
  }
}