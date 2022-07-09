import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/group/_feed.dart';
import 'package:fritter/group/_settings.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/ui/errors.dart';
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

    return Provider<GroupModel>(
      create: (context) => GroupModel(args.id),
      child: _SubscriptionGroupScreen(id: args.id, name: args.name),
    );
  }
}

class SubscriptionGroupScreenContent extends StatefulWidget {
  final String id;
  final ScrollController scrollController;

  const SubscriptionGroupScreenContent({Key? key, required this.id, required this.scrollController}) : super(key: key);

  @override
  State<SubscriptionGroupScreenContent> createState() => _SubscriptionGroupScreenContentState();
}

class _SubscriptionGroupScreenContentState extends State<SubscriptionGroupScreenContent> {
  @override
  void initState() {
    super.initState();

    context.read<GroupModel>().loadGroup(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GroupModel, Object, SubscriptionGroupGet>.transition(
      store: context.read<GroupModel>(),
      onLoading: (_) => const Center(child: Text('lad')),
      onError: (_, error) =>
          ScaffoldErrorWidget(error: error, stackTrace: null, prefix: L10n.current.unable_to_load_the_group),
      onState: (_, group) {
        // TODO: This is pretty gross. Figure out how to have a "no data" state
        if (group.id.isEmpty) {
          return Container();
        }

        var users = group.subscriptions.map((e) => e.screenName).toList();

        return SubscriptionGroupFeed(
          group: group,
          users: users,
          includeReplies: group.includeReplies,
          includeRetweets: group.includeRetweets,
          scrollController: widget.scrollController,
        );
      },
    );
  }
}

class _SubscriptionGroupScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final String id;
  final String name;

  _SubscriptionGroupScreen({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<GroupModel>();

    return Scaffold(
      appBar: AppBar(title: Text(name), actions: [
        IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: () async {
              await _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
            }),
        IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await context.read<GroupModel>().loadGroup(id);
            }),
        IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showFeedSettings(context, model))
      ]),
      body: SubscriptionGroupScreenContent(
        id: id,
        scrollController: _scrollController,
      ),
    );
  }
}
