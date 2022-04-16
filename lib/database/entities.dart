import 'dart:ui';

import 'package:fritter/group/group_model.dart';

mixin ToMappable {
  Map<String, dynamic> toMap();
}

class SavedTweet with ToMappable {
  final String id;
  final String content;

  SavedTweet({required this.id, required this.content});

  factory SavedTweet.fromMap(Map<String, Object?> map) {
    return SavedTweet(id: map['id'] as String, content: map['content'] as String);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content};
  }
}

class Subscription with ToMappable {
  final String id;
  final String screenName;
  final String name;
  final String? profileImageUrlHttps;
  final bool verified;

  Subscription(
      {required this.id,
      required this.screenName,
      required this.name,
      required this.profileImageUrlHttps,
      required this.verified});

  factory Subscription.fromMap(Map<String, Object?> map) {
    // TODO: Remove this after a while, as it's to handle broken exports from v2.10.0
    var verifiedIsBool = map['verified'] is bool;
    var verifiedIsInt = map['verified'] is int;

    return Subscription(
        id: map['id'] as String,
        screenName: map['screen_name'] as String,
        name: map['name'] as String,
        profileImageUrlHttps: map['profile_image_url_https'] as String?,
        verified: verifiedIsBool
            ? map['verified'] as bool
            : verifiedIsInt
                ? map['verified'] == 1
                : false);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'screen_name': screenName, 'name': name, 'verified': verified ? 1 : 0};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Subscription && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class SubscriptionGroup with ToMappable {
  final String id;
  final String name;
  final String icon;
  final Color? color;
  final int numberOfMembers;
  final DateTime createdAt;

  SubscriptionGroup(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      required this.numberOfMembers,
      required this.createdAt});

  factory SubscriptionGroup.fromMap(Map<String, Object?> json) {
    // This is here to handle imports of data from before v2.15.0
    var icon = json['icon'] as String?;
    if (icon == null || icon == 'rss_feed' || icon == '') {
      icon = defaultGroupIcon;
    }

    return SubscriptionGroup(
        id: json['id'] as String,
        name: json['name'] as String,
        icon: icon,
        color: json['color'] == null ? null : Color(json['color'] as int),
        numberOfMembers: json['number_of_members'] == null ? 0 : json['number_of_members'] as int,
        createdAt: DateTime.parse(json['created_at'] as String));
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'icon': icon, 'color': color?.value, 'created_at': createdAt.toIso8601String()};
  }
}

class SubscriptionGroupGet {
  final String id;
  final String name;
  final List<Subscription> subscriptions;

  SubscriptionGroupGet({required this.id, required this.name, required this.subscriptions});
}

class SubscriptionGroupEdit {
  final String? id;
  String name;
  String icon;
  Color? color;
  Set<String> members;

  SubscriptionGroupEdit(
      {required this.id, required this.name, required this.icon, required this.color, required this.members});
}

class SubscriptionGroupMember with ToMappable {
  final String group;
  final String profile;

  SubscriptionGroupMember({required this.group, required this.profile});

  factory SubscriptionGroupMember.fromMap(Map<String, Object?> json) {
    return SubscriptionGroupMember(group: json['group_id'] as String, profile: json['profile_id'] as String);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'group_id': group, 'profile_id': profile};
  }
}

class SubscriptionGroupSettings {
  final bool includeReplies;
  final bool includeRetweets;

  SubscriptionGroupSettings({required this.includeReplies, required this.includeRetweets});
}
