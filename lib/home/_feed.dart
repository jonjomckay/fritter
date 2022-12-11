import 'package:flutter/material.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';

class FeedScreen extends StatefulWidget {
  final ScrollController scrollController;
  final String id;
  final String name;

  const FeedScreen({Key? key, required this.scrollController, required this.id, required this.name}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with AutomaticKeepAliveClientMixin<FeedScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SubscriptionGroupScreen(scrollController: widget.scrollController,
        id: widget.id,
        name: widget.name,
        actions: createCommonAppBarActions(context));
  }
}