import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/profile/_tweets.dart';
import 'package:fritter/tweet.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';

class StatusScreen extends StatefulWidget {
  final String username;
  final String id;

  const StatusScreen({Key? key, required this.username, required this.id}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  late Future<TweetStatus> _future;

  @override
  void initState() {
    super.initState();

    fetchStatus();
  }

  void fetchStatus() {
    setState(() {
      _future = Twitter.getTweet(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilderWrapper<TweetStatus>(
        future: _future,
        onReady: (status) => StatusScreenBody(status: status, username: widget.username),
        onError: (error, stackTrace) => FullPageErrorWidget(
          error: error,
          stackTrace: stackTrace,
          prefix: 'Unable to load the tweet',
          onRetry: () => fetchStatus(),
        ),
      ),
    );
  }
}

class StatusScreenBody extends StatefulWidget {
  final String username;
  final TweetStatus status;

  const StatusScreenBody({Key? key, required this.username, required this.status}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusScreenBodyState();
}

class _StatusScreenBodyState extends State<StatusScreenBody> {

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> comments = [];

    var replies = widget.status.chains;
    if (replies.isEmpty) {
      comments = [Text('No replies')];
    } else {
      comments = replies.map((chain) {
        // TODO: Is widget.username correct here?
        return TweetConversation(id: chain.id, username: widget.username, tweets: chain.tweets, showFullThreadButton: false);
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          TweetTile(currentUsername: widget.username, tweet: widget.status.tweet, clickable: false),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [...comments],
            ),
          )
        ],
      ),
    );
  }
}