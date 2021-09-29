import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/group/_feed.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:provider/provider.dart';

class GroupScreenArguments {
  final String id;
  final String name;

  GroupScreenArguments({required this.id, required this.name});
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
      var subscriptions = (await database.query(TABLE_SUBSCRIPTION))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(id: '-1', name: 'All', subscriptions: subscriptions);
    } else {
      var group = (await database.query(TABLE_SUBSCRIPTION_GROUP, where: 'id = ?', whereArgs: [id]))
          .first;

      var subscriptions = (await database.rawQuery('SELECT s.* FROM $TABLE_SUBSCRIPTION s LEFT JOIN $TABLE_SUBSCRIPTION_GROUP_MEMBER sgm ON sgm.profile_id = s.id WHERE sgm.group_id = ?', [id]))
          .map((e) => Subscription.fromMap(e))
          .toList(growable: false);

      return SubscriptionGroupGet(id: group['id'] as String, name: group['name'] as String, subscriptions: subscriptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupModel>(builder: (context, model, child) {
      return FutureBuilderWrapper<SubscriptionGroupGet>(
        future: _findSubscriptionGroup(id),
        onError: (error, stackTrace) => ScaffoldErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to load the group'),
        onReady: (group) {
          var users = group.subscriptions.map((e) => e.screenName).toList();

          return FutureBuilderWrapper<SubscriptionGroupSettings>(
            future: model.loadSubscriptionGroupSettings(group.id),
            onError: (error, stackTrace) => ScaffoldErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to load the group settings'),
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
      appBar: AppBar(
          title: Text(widget.name),
          actions: [
            IconButton(icon: Icon(Icons.arrow_upward), onPressed: () async {
              await _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            }),
            IconButton(icon: Icon(Icons.refresh), onPressed: () async {
              // This is a dirty hack, and probably won't work if the child widgets ever become stateful
              setState(() {});
            }),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                var theme = Theme.of(context);

                return Container(
                  height: 220,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25),
                        topRight: const Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                            child: ListTile(
                              leading: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }
                              ),
                              title: Text('Filters'),
                              tileColor: theme.colorScheme.primary,
                            )
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
                            child: Text('Note: Due to a Twitter limitation, not all tweets may be included', style: TextStyle(
                                color: Theme.of(context).disabledColor
                            ))
                        ),
                        Consumer<GroupModel>(builder: (context, model, child) {
                          return FutureBuilderWrapper<SubscriptionGroupSettings>(
                            future: model.loadSubscriptionGroupSettings(widget.id),
                            onError: (error, stackTrace) => InlineErrorWidget(error: error),
                            onReady: (settings) => Column(
                              children: [
                                CheckboxListTile(title: Text('Include replies'), value: settings.includeReplies, onChanged: (value) async {
                                  await model.toggleSubscriptionGroupIncludeReplies(widget.id, value ?? false);
                                }),
                                CheckboxListTile(title: Text('Include retweets'), value: settings.includeRetweets, onChanged: (value) async {
                                  await model.toggleSubscriptionGroupIncludeRetweets(widget.id, value ?? false);
                                }),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                );
              });
            })
          ]
      ),
      body: SubscriptionGroupScreenContent(
        id: widget.id,
        scrollController: _scrollController,
      ),
    );
  }
}
