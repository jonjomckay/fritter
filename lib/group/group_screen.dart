import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/tweet.dart';
import 'package:pagination_view/pagination_view.dart';

class SubscriptionGroupScreen extends StatefulWidget {
  final int id;

  const SubscriptionGroupScreen({Key? key, required this.id}) : super(key: key);

  @override
  _SubscriptionGroupScreenState createState() => _SubscriptionGroupScreenState();
}

class _SubscriptionGroupScreenState extends State<SubscriptionGroupScreen> {
  String? _maxId;

  Future<SubscriptionGroupGet> _findSubscriptionGroup(int id) async {
    var database = await Repository.readOnly();

    if (id == -1) {
      var subscriptions = (await database.query(TABLE_SUBSCRIPTION))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(id: -1, name: 'All', subscriptions: subscriptions);
    } else {
      var group = (await database.query(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: [id]))
          .first;

      var subscriptions = (await database.rawQuery('SELECT s.id, s.name, s.screen_name, s.profile_image_url_https FROM $TABLE_SUBSCRIPTION s LEFT JOIN $TABLE_SUBSCRIPTION_GROUP_MEMBER sgm ON sgm.profile_id = s.id WHERE sgm.group_id = ?', [id]))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(id: group['id'] as int, name: group['name'] as String, subscriptions: subscriptions);
    }
  }

  Future<List<TweetWithCard>> _listTweets(List<String> users) async {
    List<Future<List<TweetWithCard>>> futures = [];

    // TODO: Split into groups, and have a max_id per group

    var query = '';
    for (var user in users) {
      var queryToAdd = 'from:$user';

      // If we can add this user to the query and still be less than 500 characters, do so
      if (query.length + queryToAdd.length < 100) {
        if (query.length > 0) {
          query += '+OR+';
        }

        query += queryToAdd;
      } else {
        // Otherwise, add the search future and start a new one
        futures.add(Twitter.searchTweets(query, limit: 100, maxId: _maxId));

        query = queryToAdd;
      }
    }

    // Add any remaining query as a search future too
    futures.add(Twitter.searchTweets(query, limit: 100, maxId: _maxId));

    var result = (await Future.wait(futures))
      .expand((element) => element)
      .where((element) => element.idStr != _maxId)
      .toList();

    result.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    if (result.isNotEmpty) {
      setState(() {
        _maxId = result.last.idStr;
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SubscriptionGroupGet>(
      future: _findSubscriptionGroup(widget.id),
      builder: (context, snapshot) {
        var group = snapshot.data;
        if (group == null) {
          return Center(child: CircularProgressIndicator());
        }

        var users = group.subscriptions.map((e) => e.screenName).toList();

        // TODO: Nesting the scaffold looks weird on the device when loading
        return Scaffold(
          appBar: AppBar(
            title: Text(group.name),
          ),
          body: PaginationView<TweetWithCard>(
            itemBuilder: (BuildContext context, TweetWithCard tweet, int index) {
              return TweetTile(tweet: tweet, clickable: true);
            },
            paginationViewType: PaginationViewType.listView,
            pageFetch: (currentListSize) async {
              return _listTweets(users);
            },
            onError: (dynamic error) => Center(
              // TODO
              child: Text('Some error occurred'),
            ),
            onEmpty: Center(
              child: Text('Couldn\'t find any tweets from the last 7 days!'),
            ),
            bottomLoader: Center(
              child: CircularProgressIndicator(),
            ),
            initialLoader: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
