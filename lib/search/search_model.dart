import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/client.dart';
import 'package:fritter/user.dart';

class SearchTweetsModel extends StreamStore<Object, List<TweetWithCard>> {
  SearchTweetsModel() : super([]);

  Future<void> searchTweets(String query) async {
    await execute(() async {
      if (query.isEmpty) {
        return [];
      } else {
        // TODO: Is this right?
        return (await Twitter.searchTweets(query, true)).chains.map((e) => e.tweets).expand((element) => element).toList();
      }
    });
  }
}

class SearchUsersModel extends StreamStore<Object, List<UserWithExtra>> {
  SearchUsersModel() : super([]);

  Future<void> searchUsers(String query) async {
    await execute(() async {
      if (query.isEmpty) {
        return [];
      } else {
        return await Twitter.searchUsers(query);
      }
    });
  }
}