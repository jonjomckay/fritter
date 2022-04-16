import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/group/_feed.dart';
import 'package:fritter/group/_settings.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:provider/provider.dart';

class GroupScreenArguments {
  final String id;
  final String name;

  GroupScreenArguments({required this.id, required this.name});

  @override
  String toString() {
    return 'GroupScreenArguments{id: $id, name: $name}';
  }
}

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupScreenArguments;

    return _SubscriptionGroupScreen(id: args.id, name: args.name);
  }
}

class SubscriptionGroupScreenContent extends StatelessWidget {
  final String id;
  final ScrollController scrollController;

  const SubscriptionGroupScreenContent({Key? key, required this.id, required this.scrollController}) : super(key: key);

  Future<SubscriptionGroupGet> _findSubscriptionGroup(String id) async {
    var database = await Repository.readOnly();

    if (id == '-1') {
      var subscriptions =
          (await database.query(tableSubscription)).map((e) => Subscription.fromMap(e)).toList(growable: false);

      return SubscriptionGroupGet(id: '-1', name: 'All', subscriptions: subscriptions);
    } else {
      var group = (await database.query(tableSubscriptionGroup, where: 'id = ?', whereArgs: [id])).first;

      var subscriptions = (await database.rawQuery(
              'SELECT s.* FROM $tableSubscription s LEFT JOIN $tableSubscriptionGroupMember sgm ON sgm.profile_id = s.id WHERE sgm.group_id = ?',
              [id]))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(
          id: group['id'] as String, name: group['name'] as String, subscriptions: subscriptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupModel>(builder: (context, model, child) {
      return FutureBuilderWrapper<SubscriptionGroupGet>(
        future: _findSubscriptionGroup(id),
        onError: (error, stackTrace) => ScaffoldErrorWidget(
            error: error, stackTrace: stackTrace, prefix: L10n.of(context).unable_to_load_the_group),
        onReady: (group) {
          var users = group.subscriptions.map((e) => e.screenName).toList();

          return FutureBuilderWrapper<SubscriptionGroupSettings>(
            future: model.loadSubscriptionGroupSettings(group.id),
            onError: (error, stackTrace) => ScaffoldErrorWidget(
              error: error,
              stackTrace: stackTrace,
              prefix: L10n.of(context).unable_to_load_the_group_settings,
            ),
            onReady: (settings) {
              return SubscriptionGroupFeed(
                group: group,
                users: users,
                includeReplies: settings.includeReplies,
                includeRetweets: settings.includeRetweets,
                scrollController: scrollController,
              );
            },
          );
        },
      );
    });
  }
}

class _SubscriptionGroupScreen extends StatefulWidget {
  final String id;
  final String name;

  const _SubscriptionGroupScreen({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  _SubscriptionGroupScreenState createState() => _SubscriptionGroupScreenState();
}

class _SubscriptionGroupScreenState extends State<_SubscriptionGroupScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name), actions: [
        IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: () async {
              await _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
            }),
        IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // This is a dirty hack, and probably won't work if the child widgets ever become stateful
              setState(() {});
            }),
        IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showFeedSettings(context, widget.id))
      ]),
      body: SubscriptionGroupScreenContent(
        id: widget.id,
        scrollController: _scrollController,
      ),
    );
  }
}
