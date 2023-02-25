import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/_feed.dart';
import 'package:fritter/group/_settings.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';

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

    return SubscriptionGroupScreen(scrollController: ScrollController(), id: args.id, name: args.name, actions: []);
  }
}

class SubscriptionGroupScreenContent extends StatelessWidget {
  final String id;

  const SubscriptionGroupScreenContent({Key? key, required this.id}) : super(key: key);

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

        // Split the users into chunks, oldest first, to prevent thrashing of all groups when a new user is added
        var users = group.subscriptions
            .sorted((a, b) => a.createdAt.compareTo(b.createdAt))
            .toList();

        var chunks = partition(users, 16)
            .map((e) => SubscriptionGroupFeedChunk(e, group.includeReplies, group.includeRetweets))
            .toList();

        return SubscriptionGroupFeed(
          group: group,
          chunks: chunks,
          includeReplies: group.includeReplies,
          includeRetweets: group.includeRetweets,
        );
      },
    );
  }
}

class SubscriptionGroupFeedChunk {
  final List<Subscription> users;
  final bool includeReplies;
  final bool includeRetweets;

  SubscriptionGroupFeedChunk(this.users, this.includeReplies, this.includeRetweets);

  String get hash {
    var toHash = '${users.map((e) => e.id).join(', ')}$includeReplies$includeRetweets';

    return sha1.convert(toHash.codeUnits).toString();
  }
}

class SubscriptionGroupScreen extends StatelessWidget {
  final ScrollController scrollController;
  final String id;
  final String name;
  final List<Widget> actions;

  const SubscriptionGroupScreen({Key? key, required this.scrollController, required this.id, required this.name, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GroupModel>(
      create: (context) {
        var model = GroupModel(id);
        model.loadGroup();

        return model;
      },
      builder: (context, child) {
        var model = context.read<GroupModel>();

        return NestedScrollView(
          controller: scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: false,
                snap: true,
                floating: true,
                title: Text(name),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => showFeedSettings(context, model)),
                  IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      onPressed: () async {
                        await scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                      }),
                  IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () async {
                        await model.loadGroup();
                      }),
                  ...actions
                ],
              )
            ];
          },
          body: SubscriptionGroupScreenContent(id: id),
        );
      },
    );
  }
}
