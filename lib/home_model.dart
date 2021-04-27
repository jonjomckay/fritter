import 'dart:convert';
import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:sqflite/sqflite.dart';

import 'database/repository.dart';
import 'database/entities.dart';

class HomeModel extends ChangeNotifier {
  Future deleteSubscriptionGroup(int id) async {
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

  Future<List<TweetWithCard>> listSavedTweets() async {
    log('Listing saved tweets');

    var database = await Repository.readOnly();

    return (await database.query(TABLE_SAVED_TWEET, orderBy: 'saved_at DESC'))
        .map((e) => TweetWithCard.fromJson(jsonDecode(e['content'] as String)))
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

  Future<List<Trends>> loadTrends() async {
    return Twitter.getTrends();
  }

  Future<List<SubscriptionGroup>> listSubscriptionGroups() async {
    var database = await Repository.readOnly();

    return (await database.query(TABLE_SUBSCRIPTION_GROUP))
        .map((e) => SubscriptionGroup(id: e['id'] as int, name: e['name'] as String))
        .toList(growable: false);
  }


  Future<SubscriptionGroupEdit> loadSubscriptionGroupEdit(int? id) async {
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
      ? 'ASC'
      : 'DESC';

    return (await database.query(TABLE_SUBSCRIPTION, orderBy: '$orderBy $orderByDirection'))
        .map((e) => Subscription.fromMap(e))
        .toList(growable: false);
  }

  Future refresh() async {
    notifyListeners();
  }

  Future saveSubscriptionGroup(int? id, String name, List<Subscription> subscriptions) async {
    var database = await Repository.writable();

    // First insert or update the subscription group details
    if (id == null) {
      id = await database.insert(TABLE_SUBSCRIPTION_GROUP, {
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
}