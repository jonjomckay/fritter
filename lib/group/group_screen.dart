import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/tweet.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SubscriptionGroupFeed extends StatefulWidget {
  final SubscriptionGroupGet group;
  final List<String> users;

  const SubscriptionGroupFeed({Key? key, required this.group, required this.users}) : super(key: key);

  @override
  _SubscriptionGroupFeedState createState() => _SubscriptionGroupFeedState();
}

class _SubscriptionGroupFeedState extends State<SubscriptionGroupFeed> {
  late PagingController<String?, TweetWithCard> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: null);
    _pagingController.addPageRequestListener((cursor) {
      _listTweets(cursor);
    });
  }

  Future _listTweets(String? cursor) async {
    List<Future<List<TweetWithCard>>> futures = [];

    // TODO: Split into groups, and have a max_id per group

    var query = '';
    for (var user in widget.users) {
      var queryToAdd = 'from:$user';

      // If we can add this user to the query and still be less than 500 characters, do so
      if (query.length + queryToAdd.length < 100) {
        if (query.length > 0) {
          query += '+OR+';
        }

        query += queryToAdd;
      } else {
        // Otherwise, add the search future and start a new one
        futures.add(Twitter.searchTweets(query, limit: 100, maxId: cursor));

        query = queryToAdd;
      }
    }

    // Add any remaining query as a search future too
    futures.add(Twitter.searchTweets(query, limit: 100, maxId: cursor));

    var result = (await Future.wait(futures))
        .expand((element) => element)
        .where((element) => element.idStr != cursor)
        .toList();

    result.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    if (result.isNotEmpty) {
      _pagingController.appendPage(result, result.last.idStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Nesting the scaffold looks weird on the device when loading
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: PagedListView<String?, TweetWithCard>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, tweet, index) {
            return TweetTile(tweet: tweet, clickable: true);
          },
          // TODO
          newPageErrorIndicatorBuilder: (context) => Text('Some error occurred'),
          firstPageErrorIndicatorBuilder: (context) => Text('Some error occurred'),
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: Text('Couldn\'t find any tweets from the last 7 days!'),
          ),
        ),
      ),
    );
  }
}


class SubscriptionGroupScreen extends StatefulWidget {
  final String id;

  const SubscriptionGroupScreen({Key? key, required this.id}) : super(key: key);

  @override
  _SubscriptionGroupScreenState createState() => _SubscriptionGroupScreenState();
}

class _SubscriptionGroupScreenState extends State<SubscriptionGroupScreen> {
  Future<SubscriptionGroupGet> _findSubscriptionGroup(String id) async {
    var database = await Repository.readOnly();

    if (id == '-1') {
      var subscriptions = (await database.query(TABLE_SUBSCRIPTION))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(id: '-1', name: 'All', subscriptions: subscriptions);
    } else {
      var group = (await database.query(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: [id]))
          .first;

      var subscriptions = (await database.rawQuery('SELECT s.id, s.name, s.screen_name, s.profile_image_url_https FROM $TABLE_SUBSCRIPTION s LEFT JOIN $TABLE_SUBSCRIPTION_GROUP_MEMBER sgm ON sgm.profile_id = s.id WHERE sgm.group_id = ?', [id]))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(id: group['id'] as String, name: group['name'] as String, subscriptions: subscriptions);
    }
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

        return SubscriptionGroupFeed(
            group: group,
            users: users,
        );
      },
    );
  }
}
