import 'package:flutter/material.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/_settings.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class FeedScreen extends StatefulWidget {
  final ScrollController scrollController;

  const FeedScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GroupModel model = GroupModel('-1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: I think this is the same as in group_screen?
      appBar: ScrollAppBar(
        controller: widget.scrollController,
        title: Text(L10n.current.feed),
        actions: [
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showFeedSettings(context, model)),
          IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () async {
                await widget.scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
              }),
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                await model.loadGroup('-1');
              }),
          ...createCommonAppBarActions(context)
        ],
      ),
      body: Provider<GroupModel>(
        create: (_) => model,
        child: SubscriptionGroupScreenContent(id: '-1', scrollController: widget.scrollController),
      ),
    );
  }
}