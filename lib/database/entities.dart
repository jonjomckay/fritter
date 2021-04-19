class Following {
  final String id;
  final String screenName;
  final String name;
  final String? profileImageUrlHttps;

  Following({ required this.id, required this.screenName, required this.name, required this.profileImageUrlHttps });

  factory Following.fromMap(Map<String, Object?> map) {
    return Following(
        id: map['id'] as String,
        screenName: map['screen_name'] as String,
        name: map['name'] as String,
        profileImageUrlHttps: map['profile_image_url_https'] as String?
    );
  }
}

class SubscriptionGroup {
  final int id;
  final String name;

  SubscriptionGroup({required this.id, required this.name});
}

class SubscriptionGroupGet {
  final int id;
  final String name;
  final List<Following> following;

  SubscriptionGroupGet({required this.id, required this.name, required this.following});
}

class SubscriptionGroupEdit {
  final String name;
  final Set<String> following;
  final List<Following> allFollowing;

  SubscriptionGroupEdit({required this.name, required this.following, required this.allFollowing});
}