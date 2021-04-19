import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';

import 'database.dart';
import 'database/entities.dart';

class HomeModel extends ChangeNotifier {
  Future deleteSubscriptionGroup(int id) async {
    var database = await Repository.writable();

    await database.delete('following_group_profile', where: 'group_id = ?', whereArgs: [id]);
    await database.delete('following_group', where: 'id = ?', whereArgs: [id]);

    notifyListeners();
  }

  Future<List<Trends>> loadTrends() async {
    return Twitter.getTrends();
  }

  Future<List<SubscriptionGroup>> listSubscriptionGroups() async {
    var database = await Repository.readOnly();

    return (await database.query('following_group'))
        .map((e) => SubscriptionGroup(id: e['id'] as int, name: e['name'] as String))
        .toList(growable: false);
  }


  Future<SubscriptionGroupEdit> loadSubscriptionGroupEdit(int? id) async {
    var database = await Repository.readOnly();

    var allFollowing = await listFollowing();

    if (id == null) {
      return SubscriptionGroupEdit(
          name: '',
          following: Set(),
          allFollowing: allFollowing
      );
    }

    var group = await database.query('following_group', where: 'id = ?', whereArgs: [id]);
    if (group.isEmpty) {
      return SubscriptionGroupEdit(
          name: '',
          following: Set(),
          allFollowing: allFollowing
      );
    }

    var following = (await database.query('following_group_profile', where: 'group_id = ?', whereArgs: [id]))
      .map((e) => e['profile_id'] as String)
      .toSet();

    return SubscriptionGroupEdit(
        name: group.first['name'] as String,
        following: following,
        allFollowing: allFollowing
    );
  }

  Future<List<Following>> listFollowing() async {
    var database = await Repository.readOnly();

    return (await database.query('following', orderBy: 'screen_name'))
        .map((e) => Following.fromMap(e))
        .toList(growable: false);
  }

  Future refresh() async {
    notifyListeners();
  }

  Future saveSubscriptionGroup(int? id, String name, List<Following> subscriptions) async {
    var database = await Repository.writable();

    // First insert or update the subscription group details
    if (id == null) {
      id = await database.insert('following_group', {
        'id': id,
        'name': name,
        'icon': ''
      });
    } else {
      await database.update('following_group', {
        'name': name,
        'icon': ''
      }, where: 'id = ?', whereArgs: [id]);
    }

    // Then clear out any existing subscriptions for the group and add our new set
    await database.delete('following_group_profile', where: 'group_id = ?', whereArgs: [id]);

    var batch = database.batch();
    for (var subscription in subscriptions) {
      batch.insert('following_group_profile', {
        'group_id': id,
        'profile_id': subscription.id
      });
    }

    await batch.commit(noResult: true);

    notifyListeners();
  }
}