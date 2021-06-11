import 'package:flutter/material.dart';
import 'package:fritter/group/group_screen.dart';

class FeedContent extends StatefulWidget {
  const FeedContent({Key? key}) : super(key: key);

  @override
  _FeedContentState createState() => _FeedContentState();
}

class _FeedContentState extends State<FeedContent> {
  @override
  Widget build(BuildContext context) {
    return SubscriptionGroupScreenContent(id: '-1');
  }
}
