import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
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

    return SubscriptionGroupScreen(scrollController: ScrollController(), id: args.id, name: args.name, actions: const []);
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

            // TODO
            if (group.subscriptions.isEmpty) {
              return Scaffold(
                body: Center(
                  child: Text(L10n.of(context).this_group_contains_no_subscriptions),
                ),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(group.name),
              ),
              body: Text('TODO: Display the group members here'),
            );
          },
        );
      },
    );
  }
}
