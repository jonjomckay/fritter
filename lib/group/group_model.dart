import 'dart:convert';
import 'dart:developer';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';
import 'package:uuid/uuid.dart';

var defaultGroupIcon = '{"pack":"material","key":"rss_feed"}';

IconData? deserializeIconData(String iconData) {
  try {
    var icon = deserializeIcon(jsonDecode(iconData));
    if (icon != null) {
      return icon;
    }
  } catch (e, stackTrace) {
    Catcher.reportCheckedError(e, stackTrace);
    log('Unable to deserialize icon', error: e, stackTrace: stackTrace);
  }

  // Use this as a default;
  return Icons.rss_feed;
}

class GroupModel extends ChangeNotifier {
  static final log = Logger('GroupModel');

  List<SubscriptionGroup> _groups = [];

  final BasePrefService _prefs;

  GroupModel(this._prefs);

  bool get orderGroupsAscending => _prefs.get(optionSubscriptionGroupsOrderByAscending);
  String get orderGroupsBy => _prefs.get(optionSubscriptionGroupsOrderByField);
  List<SubscriptionGroup> get groups => List.unmodifiable(_groups);

  Future deleteGroup(String id) async {
    var database = await Repository.writable();

    await database.delete(tableSubscriptionGroupMember, where: 'group_id = ?', whereArgs: [id]);
    await database.delete(tableSubscriptionGroup, where: 'id = ?', whereArgs: [id]);

    await reloadGroups();

    notifyListeners();
  }

  Future reloadGroups() async {
    log.info('Listing subscriptions groups');

    var database = await Repository.readOnly();

    var orderByDirection = orderGroupsAscending ? 'COLLATE NOCASE ASC' : 'COLLATE NOCASE DESC';

    var query =
        "SELECT g.id, g.name, g.icon, g.color, g.created_at, COUNT(gm.profile_id) AS number_of_members FROM $tableSubscriptionGroup g LEFT JOIN $tableSubscriptionGroupMember gm ON gm.group_id = g.id WHERE g.id != '-1' GROUP BY g.id ORDER BY $orderGroupsBy $orderByDirection";

    _groups = (await database.rawQuery(query)).map((e) => SubscriptionGroup.fromMap(e)).toList(growable: false);

    notifyListeners();
  }

  Future<List<SubscriptionGroupMember>> listGroupMembers() async {
    var database = await Repository.readOnly();

    return (await database.query(tableSubscriptionGroupMember))
        .map((e) => SubscriptionGroupMember(group: e['group_id'] as String, profile: e['profile_id'] as String))
        .toList(growable: false);
  }

  Future<List<String>> listGroupsForUser(String user) async {
    var database = await Repository.readOnly();

    return (await database.query(tableSubscriptionGroupMember,
            columns: ['group_id'], where: 'profile_id = ?', whereArgs: [user]))
        .map((e) => e['group_id'] as String)
        .toList(growable: false);
  }

  Future saveUserGroupMembership(String user, List<String> memberships) async {
    var database = await Repository.writable();

    var batch = database.batch();

    // First, clear all the memberships for the user
    batch.delete(tableSubscriptionGroupMember, where: 'profile_id = ?', whereArgs: [user]);

    // Then add all the new memberships
    for (var group in memberships) {
      batch.insert(tableSubscriptionGroupMember, {'group_id': group, 'profile_id': user});
    }

    await batch.commit();
    await reloadGroups();
  }

  Future<SubscriptionGroupEdit> loadGroupEdit(String? id) async {
    var database = await Repository.readOnly();

    if (id == null) {
      return SubscriptionGroupEdit(
        id: null,
        name: '',
        icon: defaultGroupIcon,
        color: null,
        members: <String>{},
      );
    }

    var group = await database.query(tableSubscriptionGroup, where: 'id = ?', whereArgs: [id]);
    if (group.isEmpty) {
      return SubscriptionGroupEdit(
        id: null,
        name: '',
        icon: defaultGroupIcon,
        color: null,
        members: <String>{},
      );
    }

    var members = (await database.query(tableSubscriptionGroupMember, where: 'group_id = ?', whereArgs: [id]))
        .map((e) => e['profile_id'] as String)
        .toSet();

    return SubscriptionGroupEdit(
      id: group.first['id'] as String,
      name: group.first['name'] as String,
      icon: group.first['icon'] as String,
      color: group.first['color'] == null ? null : Color(group.first['color'] as int),
      members: members,
    );
  }

  Future saveGroup(String? id, String name, String icon, Color? color, Set<String> subscriptions) async {
    var database = await Repository.writable();

    // First insert or update the subscription group details
    if (id == null) {
      id = const Uuid().v4();

      await database.insert(tableSubscriptionGroup, {'id': id, 'name': name, 'color': color?.value, 'icon': icon});
    } else {
      await database.update(
          tableSubscriptionGroup,
          {
            'name': name,
            'color': color?.value,
            'icon': icon,
          },
          where: 'id = ?',
          whereArgs: [id]);
    }

    // Then clear out any existing subscriptions for the group and add our new set
    await database.delete(tableSubscriptionGroupMember, where: 'group_id = ?', whereArgs: [id]);

    var batch = database.batch();
    for (var subscription in subscriptions) {
      batch.insert(tableSubscriptionGroupMember, {'group_id': id, 'profile_id': subscription});
    }

    await batch.commit(noResult: true);
    await reloadGroups();

    notifyListeners();
  }

  Future toggleSubscriptionGroupIncludeReplies(String id, bool value) async {
    var database = await Repository.writable();

    await database.rawUpdate('UPDATE $tableSubscriptionGroup SET include_replies = ? WHERE id = ?', [value, id]);

    notifyListeners();
  }

  Future toggleSubscriptionGroupIncludeRetweets(String id, bool value) async {
    var database = await Repository.writable();

    await database.rawUpdate('UPDATE $tableSubscriptionGroup SET include_retweets = ? WHERE id = ?', [value, id]);

    notifyListeners();
  }

  Future<SubscriptionGroupSettings> loadSubscriptionGroupSettings(String id) async {
    var database = await Repository.readOnly();

    return (await database
            .rawQuery('SELECT include_replies, include_retweets FROM $tableSubscriptionGroup WHERE id = ?', [id]))
        .map((e) => SubscriptionGroupSettings(
            includeReplies: e['include_replies'] == 1, includeRetweets: e['include_retweets'] == 1))
        .first;
  }

  void changeOrderSubscriptionGroupsBy(String? value) async {
    await _prefs.set(optionSubscriptionGroupsOrderByField, value ?? 'name');
    await reloadGroups();
  }

  void toggleOrderSubscriptionGroupsAscending() async {
    await _prefs.set(optionSubscriptionGroupsOrderByAscending, !orderGroupsAscending);
    await reloadGroups();
  }
}
