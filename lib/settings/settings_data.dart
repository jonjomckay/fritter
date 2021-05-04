import 'package:fritter/database/entities.dart';

class SettingsData {
  final Map<String, dynamic>? settings;
  final List<Subscription>? subscriptions;
  final List<SubscriptionGroup>? subscriptionGroups;
  final List<SubscriptionGroupMember>? subscriptionGroupMembers;
  final List<SavedTweet>? tweets;

  SettingsData({ required this.settings, required this.subscriptions, required this.subscriptionGroups, required this.subscriptionGroupMembers, required this.tweets});

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
        settings: json['settings'],
        subscriptions: List.from(json['subscriptions']).map((e) => Subscription.fromMap(e)).toList(),
        subscriptionGroups: List.from(json['subscriptionGroups']).map((e) => SubscriptionGroup.fromMap(e)).toList(),
        subscriptionGroupMembers: List.from(json['subscriptionGroupMembers']).map((e) => SubscriptionGroupMember.fromMap(e)).toList(),
        tweets: List.from(json['tweets']).map((e) => SavedTweet.fromMap(e)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settings': settings,
      'subscriptions': subscriptions?.map((e) => e.toMap()).toList(),
      'subscriptionGroups': subscriptionGroups?.map((e) => e.toMap()).toList(),
      'subscriptionGroupMembers': subscriptionGroupMembers?.map((e) => e.toJson()).toList(),
      'tweets': tweets?.map((e) => e.toMap()).toList()
    };
  }
}

