import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/tweet/tweet.dart';
import 'package:fritter/utils/iterables.dart';

class TweetConversation extends StatefulWidget {
  final String id;
  final String? username;
  final bool isPinned;
  final List<TweetWithCard> tweets;

  const TweetConversation(
      {Key? key, required this.id, required this.username, required this.isPinned, required this.tweets})
      : super(key: key);

  @override
  State<TweetConversation> createState() => _TweetConversationState();
}

class _TweetConversationState extends State<TweetConversation> {
  @override
  Widget build(BuildContext context) {
    if (widget.tweets.length == 1) {
      return TweetTile(
          clickable: true, tweet: widget.tweets.first, currentUsername: widget.username, isPinned: widget.isPinned);
    }

    var tiles = [];
    var tweets = widget.tweets.sorted((a, b) => a.idStr!.compareTo(b.idStr!)).toList(growable: false);

    // We need to do a simple for loop so we can mark the first item as the thread start
    for (var i = 0; i < tweets.length; i++) {
      tiles.add(TweetTile(
          clickable: true,
          tweet: tweets[i],
          currentUsername: widget.username,
          isPinned: widget.isPinned,
          isThread: i == 0));
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.white, width: 4))
      ),
      child: Column(
        children: [
          ...tiles,
        ],
      ),
    );
  }
}
