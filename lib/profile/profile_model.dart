import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/user.dart';

class Profile {
  final UserWithExtra user;
  final List<String> pinnedTweets;

  Profile(this.user, this.pinnedTweets);
}

class ProfileModel extends StreamStore<Object, Profile> {
  ProfileModel() : super(Profile(UserWithExtra(), []));

  Future<void> loadProfileById(String id) async {
    await execute(() async => await Twitter.getProfileById(id));
  }
  Future<void> loadProfileByScreenName(String screenName) async {
    await execute(() async => await Twitter.getProfileByScreenName(screenName));
  }
}