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
}

class SubscriptionGroup {
  final int id;
  final String name;

  SubscriptionGroup({required this.id, required this.name});
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