class SavedTweet {
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

class Subscription {
  final String id;
  final String screenName;
  final String name;
  final String? profileImageUrlHttps;

  Subscription({ required this.id, required this.screenName, required this.name, required this.profileImageUrlHttps });

  factory Subscription.fromMap(Map<String, Object?> map) {
    return Subscription(
        id: map['id'] as String,
        screenName: map['screen_name'] as String,
        name: map['name'] as String,
        profileImageUrlHttps: map['profile_image_url_https'] as String?
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'screen_name': screenName,
      'name': name,
    };
  }
}

class SubscriptionGroup {
  final int id;
  final String name;
  final String icon;
  final int numberOfMembers;
  final DateTime createdAt;

  SubscriptionGroup({required this.id, required this.name, required this.icon, required this.numberOfMembers, required this.createdAt});

  factory SubscriptionGroup.fromMap(Map<String, Object?> json) {
    return SubscriptionGroup(
      id: json['id'] as int,
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
  final int id;
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

class SubscriptionGroupMember {
  final int group;
  final String profile;

  SubscriptionGroupMember({required this.group, required this.profile});

  factory SubscriptionGroupMember.fromMap(Map<String, Object?> json) {
    return SubscriptionGroupMember(
      group: json['group_id'] as int,
      profile: json['profile_id'] as String
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'group_id': group,
      'profile_id': profile
    };
  }
}