import 'package:flutter/material.dart';
import 'package:fritter/group/group_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return SubscriptionGroupScreenContent(id: '-1');
  }
}
