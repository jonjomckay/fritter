import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';
import 'package:sqflite/sqflite.dart';

class HomeModel extends ChangeNotifier {
  static final log = Logger('HomeModel');

  final BasePrefService _prefs;

  HomeModel(this._prefs);

  Future<bool> isTweetSaved(String id) async {
    var database = await Repository.readOnly();

    var result = await database.rawQuery('SELECT EXISTS (SELECT 1 FROM $tableSavedTweet WHERE id = ?)', [id]);

    return Sqflite.firstIntValue(result) == 1;
  }

  Future deleteSavedTweet(String id) async {
    var database = await Repository.writable();

    await database.delete(tableSavedTweet, where: 'id = ?', whereArgs: [id]);

    notifyListeners();
  }

  Future<List<SavedTweet>> listSavedTweets() async {
    log.info('Listing saved tweets');

    var database = await Repository.readOnly();

    return (await database.query(tableSavedTweet, orderBy: 'saved_at DESC'))
        .map((e) => SavedTweet(id: e['id'] as String, content: e['content'] as String))
        .toList(growable: false);
  }

  Future saveTweet(String id, Map<String, dynamic> content) async {
    var database = await Repository.writable();

    await database.insert(tableSavedTweet, {'id': id, 'content': jsonEncode(content)});

    notifyListeners();
  }

  Future<List<Trends>> loadTrends(int location) async {
    return Twitter.getTrends(location);
  }

  Future importData(Map<String, List<ToMappable>> data) async {
    var database = await Repository.writable();

    var batch = database.batch();

    for (var pair in data.entries) {
      for (var datum in pair.value) {
        batch.insert(pair.key, datum.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      log.info('Imported data into ${pair.key}');
    }

    await batch.commit();
  }

  Future setTrendLocation(TrendLocation item) async {
    _prefs.set(optionTrendsLocation, jsonEncode(item.toJson()));

    notifyListeners();
  }
}
