import 'dart:convert';
import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:pref/pref.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'database/repository.dart';
import 'database/entities.dart';

class HomeModel extends ChangeNotifier {
  Future deleteSubscriptionGroup(String id) async {
    var database = await Repository.writable();

    await database.delete(TABLE_SUBSCRIPTION_GROUP_MEMBER, where: 'group_id = ?', whereArgs: [id]);
    await database.delete(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: [id]);

    notifyListeners();
  }

  Future<bool> isTweetSaved(String id) async {
    var database = await Repository.readOnly();

    var result = await database.rawQuery('SELECT EXISTS (SELECT 1 FROM $TABLE_SAVED_TWEET WHERE id = ?)', [id]);

    return Sqflite.firstIntValue(result) == 1;
  }

  Future deleteSavedTweet(String id) async {
    var database = await Repository.writable();

    await database.delete(TABLE_SAVED_TWEET, where: 'id = ?', whereArgs: [id]);

    notifyListeners();
  }

  Future<List<SavedTweet>> listSavedTweets() async {
    log('Listing saved tweets');

    var database = await Repository.readOnly();

    return (await database.query(TABLE_SAVED_TWEET, orderBy: 'saved_at DESC'))
        .map((e) => SavedTweet(id: e['id'] as String, content: e['content'] as String))
        .toList(growable: false);
  }

  Future saveTweet(String id, Map<String, dynamic> content) async {
    var database = await Repository.writable();

    await database.insert(TABLE_SAVED_TWEET, {
      'id': id,
      'content': jsonEncode(content)
    });

    notifyListeners();
  }

  Future<List<Trends>> loadTrends(int location) async {
    return Twitter.getTrends(location);
  }

  Future<List<SubscriptionGroup>> listSubscriptionGroups({ required String orderBy, required bool orderByAscending }) async {
    log('Listing subscriptions groups');

    var database = await Repository.readOnly();

    var orderByDirection = orderByAscending
        ? 'COLLATE NOCASE ASC'
        : 'COLLATE NOCASE DESC';

    var query = "SELECT g.id, g.name, g.icon, g.created_at, COUNT(gm.profile_id) AS number_of_members FROM $TABLE_SUBSCRIPTION_GROUP g LEFT JOIN $TABLE_SUBSCRIPTION_GROUP_MEMBER gm ON gm.group_id = g.id WHERE g.id != '-1' GROUP BY g.id ORDER BY $orderBy $orderByDirection";

    return (await database.rawQuery(query))
        .map((e) => SubscriptionGroup(id: e['id'] as String, name: e['name'] as String, icon: e['icon'] as String, numberOfMembers: e['number_of_members'] as int, createdAt: DateTime.parse(e['created_at'] as String)))
        .toList(growable: false);
  }

  Future<List<SubscriptionGroupMember>> listSubscriptionGroupMembers() async {
    var database = await Repository.readOnly();

    return (await database.query(TABLE_SUBSCRIPTION_GROUP_MEMBER))
        .map((e) => SubscriptionGroupMember(group: e['group_id'] as String, profile: e['profile_id'] as String))
        .toList(growable: false);
  }

  Future<SubscriptionGroupEdit> loadSubscriptionGroupEdit(String? id) async {
    var database = await Repository.readOnly();

    var allSubscriptions = await listSubscriptions(orderBy: 'name', orderByAscending: true);

    if (id == null) {
      return SubscriptionGroupEdit(
          name: '',
          members: Set(),
          allSubscriptions: allSubscriptions
      );
    }

    var group = await database.query(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: [id]);
    if (group.isEmpty) {
      return SubscriptionGroupEdit(
          name: '',
          members: Set(),
          allSubscriptions: allSubscriptions
      );
    }

    var members = (await database.query(TABLE_SUBSCRIPTION_GROUP_MEMBER, where: 'group_id = ?', whereArgs: [id]))
      .map((e) => e['profile_id'] as String)
      .toSet();

    return SubscriptionGroupEdit(
        name: group.first['name'] as String,
        members: members,
        allSubscriptions: allSubscriptions
    );
  }

  Future<List<Subscription>> listSubscriptions({ required String orderBy, required bool orderByAscending }) async {
    var database = await Repository.readOnly();

    var orderByDirection = orderByAscending
      ? 'COLLATE NOCASE ASC'
      : 'COLLATE NOCASE DESC';

    return (await database.query(TABLE_SUBSCRIPTION, orderBy: '$orderBy $orderByDirection'))
        .map((e) => Subscription.fromMap(e))
        .toList(growable: false);
  }

  Future refresh() async {
    notifyListeners();
  }

  Future saveSubscriptionGroup(String? id, String name, List<Subscription> subscriptions) async {
    var database = await Repository.writable();

    // First insert or update the subscription group details
    if (id == null) {
      id = Uuid().v4();

      await database.insert(TABLE_SUBSCRIPTION_GROUP, {
        'id': id,
        'name': name,
        'icon': ''
      });
    } else {
      await database.update(TABLE_SUBSCRIPTION_GROUP, {
        'name': name,
        'icon': ''
      }, where: 'id = ?', whereArgs: [id]);
    }

    // Then clear out any existing subscriptions for the group and add our new set
    await database.delete(TABLE_SUBSCRIPTION_GROUP_MEMBER, where: 'group_id = ?', whereArgs: [id]);

    var batch = database.batch();
    for (var subscription in subscriptions) {
      batch.insert(TABLE_SUBSCRIPTION_GROUP_MEMBER, {
        'group_id': id,
        'profile_id': subscription.id
      });
    }

    await batch.commit(noResult: true);

    notifyListeners();
  }

  Future importData(Map<String, List<ToMappable>> data) async {
    var database = await Repository.writable();

    var batch = database.batch();

    for (var pair in data.entries) {
      for (var datum in pair.value) {
        batch.insert(pair.key, datum.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      log('Imported data into ${pair.key}');
    }

    await batch.commit();
  }

  Future toggleSubscriptionGroupIncludeReplies(String id, bool value) async {
    var database = await Repository.writable();

    await database.rawUpdate('UPDATE $TABLE_SUBSCRIPTION_GROUP SET include_replies = ? WHERE id = ?', [value, id]);

    notifyListeners();
  }

  Future toggleSubscriptionGroupIncludeRetweets(String id, bool value) async {
    var database = await Repository.writable();

    await database.rawUpdate('UPDATE $TABLE_SUBSCRIPTION_GROUP SET include_retweets = ? WHERE id = ?', [value, id]);

    notifyListeners();
  }

  Future<SubscriptionGroupSettings> loadSubscriptionGroupSettings(String id) async {
    var database = await Repository.readOnly();

    return (await database.rawQuery('SELECT include_replies, include_retweets FROM $TABLE_SUBSCRIPTION_GROUP WHERE id = ?', [id]))
        .map((e) => SubscriptionGroupSettings(includeReplies: e['include_replies'] == 1, includeRetweets: e['include_retweets'] == 1))
        .first;
  }

  Future setTrendLocation(BasePrefService prefs, TrendLocation item) async {
    prefs.set(OPTION_TRENDS_LOCATION, jsonEncode(item.toJson()));

    notifyListeners();
  }
}