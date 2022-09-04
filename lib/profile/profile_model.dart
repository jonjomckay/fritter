import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';

class Profile {
  final User user;
  final List<String> pinnedTweets;

  Profile(this.user, this.pinnedTweets);
}

class ProfileModel extends StreamStore<Object, Profile> {
  ProfileModel() : super(Profile(User(), []));

  Future<void> loadProfile(String username) async {
    await execute(() async => await Twitter.getProfile(username));
  }
}