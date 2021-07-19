import 'package:flutter/material.dart';
import 'package:fritter/group/group_screen.dart';

class FeedScreen extends StatefulWidget {
  final ScrollController scrollController;

  const FeedScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return SubscriptionGroupScreenContent(id: '-1', scrollController: widget.scrollController);
  }
}
