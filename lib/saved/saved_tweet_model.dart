import 'dart:convert';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:logging/logging.dart';

class SavedTweetModel extends StreamStore<Object, List<SavedTweet>> {
  static final log = Logger('SavedTweetModel');

  SavedTweetModel() : super([]);

  bool isSaved(String id) {
    return state.any((e) => e.id == id);
  }

  Future<void> deleteSavedTweet(String id) async {
    var database = await Repository.writable();

    await database.delete(tableSavedTweet, where: 'id = ?', whereArgs: [id]);
    state.removeWhere((e) => e.id == id);

    update(state, force: true);
  }

  Future<void> listSavedTweets() async {
    log.info('Listing saved tweets');

    await execute(() async {
      var database = await Repository.readOnly();

      return (await database.query(tableSavedTweet, orderBy: 'saved_at DESC'))
          .map((e) => SavedTweet(id: e['id'] as String, content: e['content'] as String))
          .toList();
    });
  }

  Future<void> saveTweet(String id, Map<String, dynamic> content) async {
    log.info('Saving tweet with the ID $id');

    await execute(() async {
      var database = await Repository.writable();

      var encodedContent = jsonEncode(content);

      await database.insert(tableSavedTweet, {'id': id, 'content': encodedContent});
      state.add(SavedTweet(id: id, content: encodedContent));

      return state;
    });
  }
}
