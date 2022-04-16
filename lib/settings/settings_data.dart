import 'package:device_info/device_info.dart';
import 'package:fritter/database/entities.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as p;

const String legacyExportFileName = 'fritter.json';

Future<String> getLegacyPath(String filename) async {
  var externalStorageDirectory = await p.getExternalStorageDirectory();
  if (externalStorageDirectory == null) {
    throw Exception('Unable to find the external storage directory');
  }

  return path.join(externalStorageDirectory.path, filename);
}

Future<bool> isLegacyAndroid() async {
  var deviceInfo = await DeviceInfoPlugin().androidInfo;
  if (deviceInfo.version.sdkInt < 19) {
    return true;
  }

  return false;
}

class SettingsData {
  final Map<String, dynamic>? settings;
  final List<Subscription>? subscriptions;
  final List<SubscriptionGroup>? subscriptionGroups;
  final List<SubscriptionGroupMember>? subscriptionGroupMembers;
  final List<SavedTweet>? tweets;

  SettingsData(
      {required this.settings,
      required this.subscriptions,
      required this.subscriptionGroups,
      required this.subscriptionGroupMembers,
      required this.tweets});

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
        settings: json['settings'],
        subscriptions: json['subscriptions'] != null
            ? List.from(json['subscriptions']).map((e) => Subscription.fromMap(e)).toList()
            : null,
        subscriptionGroups: json['subscriptionGroups'] != null
            ? List.from(json['subscriptionGroups']).map((e) => SubscriptionGroup.fromMap(e)).toList()
            : null,
        subscriptionGroupMembers: json['subscriptionGroupMembers'] != null
            ? List.from(json['subscriptionGroupMembers']).map((e) => SubscriptionGroupMember.fromMap(e)).toList()
            : null,
        tweets: json['tweets'] != null ? List.from(json['tweets']).map((e) => SavedTweet.fromMap(e)).toList() : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'settings': settings,
      'subscriptions': subscriptions?.map((e) => e.toMap()).toList(),
      'subscriptionGroups': subscriptionGroups?.map((e) => e.toMap()).toList(),
      'subscriptionGroupMembers': subscriptionGroupMembers?.map((e) => e.toMap()).toList(),
      'tweets': tweets?.map((e) => e.toMap()).toList()
    };
  }
}
