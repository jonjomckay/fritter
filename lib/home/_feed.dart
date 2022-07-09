import 'package:flutter/material.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/_settings.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget with AppBarMixin {
  final GroupModel model = GroupModel('-1');
  final ScrollController scrollController;

  FeedScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  AppBar getAppBar(BuildContext context) {
    // TODO: I think this is the same as in group_screen?
    return AppBar(
      title: Text(L10n.current.feed),
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
              await model.loadGroup('-1');
            }),
        ...createCommonAppBarActions(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GroupModel>(
      create: (_) => model,
      child: SubscriptionGroupScreenContent(id: '-1', scrollController: scrollController),
    );
  }
}