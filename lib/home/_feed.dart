import 'package:flutter/material.dart';
import 'package:fritter/group/_settings.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';

class FeedScreen extends StatelessWidget {
  final ScrollController scrollController;

  const FeedScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => showFeedSettings(context, "-1")),
            IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: () async {
                  await scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                }),
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  // This is a dirty hack, and probably won't work if the child widgets ever become stateful
                  // setState(() {});
                }),
            ...createCommonAppBarActions(context)
          ],
        ),
        body: SubscriptionGroupScreenContent(id: '-1', scrollController: scrollController)
    );
  }
}