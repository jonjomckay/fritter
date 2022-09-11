import 'package:flutter/material.dart';
import 'package:fritter/group/group_screen.dart';
import 'package:fritter/home/home_screen.dart';

class FeedScreen extends StatelessWidget {
  final ScrollController scrollController;
  final String id;
  final String name;

  const FeedScreen({Key? key, required this.scrollController, required this.id, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubscriptionGroupScreen(scrollController: scrollController, id: id, name: name, actions: createCommonAppBarActions(context));
  }
}