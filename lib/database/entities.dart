mixin ToMappable {
  Map<String, dynamic> toMap();
}

class SavedTweet with ToMappable {
  final String id;
  final String content;

  SavedTweet({required this.id, required this.content});

  factory SavedTweet.fromMap(Map<String, Object?> map) {
    return SavedTweet(
      id: map['id'] as String,
      content: map['content'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content
    };
  }
}

class Subscription with ToMappable {
  final String id;
  final String screenName;
  final String name;
  final String? profileImageUrlHttps;
  final bool verified;

  Subscription({ required this.id, required this.screenName, required this.name, required this.profileImageUrlHttps, required this.verified });

  factory Subscription.fromMap(Map<String, Object?> map) {
    // TODO: Remove this after a while, as it's to handle broken exports from v2.10.0
    var verifiedIsBool = map['verified'] is bool;
    var verifiedIsInt = map['verified'] is int;

    return Subscription(
      id: map['id'] as String,
      screenName: map['screen_name'] as String,
      name: map['name'] as String,
      profileImageUrlHttps: map['profile_image_url_https'] as String?,
      verified:
        verifiedIsBool ? map['verified'] as bool :
        verifiedIsInt ? map['verified'] == 1 :
        false
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'screen_name': screenName,
      'name': name,
      'verified': verified ? 1 : 0
    };
  }
}

class SubscriptionGroup with ToMappable {
  final String id;
  final String name;
  final String icon;
  final int numberOfMembers;
  final DateTime createdAt;

  SubscriptionGroup({required this.id, required this.name, required this.icon, required this.numberOfMembers, required this.createdAt});

  factory SubscriptionGroup.fromMap(Map<String, Object?> json) {
    return SubscriptionGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      numberOfMembers: 0,
      createdAt: DateTime.parse(json['created_at'] as String)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'created_at': createdAt.toIso8601String()
    };
  }
}

class SubscriptionGroupGet {
  final String id;
  final String name;
  final List<Subscription> subscriptions;

  SubscriptionGroupGet({required this.id, required this.name, required this.subscriptions});
}

class SubscriptionGroupEdit {
  final String name;
  final Set<String> members;
  final List<Subscription> allSubscriptions;

  SubscriptionGroupEdit({required this.name, required this.members, required this.allSubscriptions});
}

class SubscriptionGroupMember with ToMappable {
  final String group;
  final String profile;

  SubscriptionGroupMember({required this.group, required this.profile});

  factory SubscriptionGroupMember.fromMap(Map<String, Object?> json) {
    return SubscriptionGroupMember(
      group: json['group_id'] as String,
      profile: json['profile_id'] as String
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'group_id': group,
      'profile_id': profile
    };
  }
}

class SubscriptionGroupSettings {
  final bool includeReplies;
  final bool includeRetweets;

  SubscriptionGroupSettings({required this.includeReplies, required this.includeRetweets});
}