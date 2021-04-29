import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/tweet.dart';

class StatusScreen extends StatelessWidget {
  final String username;
  final String id;

  const StatusScreen({Key? key, required this.username, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StatusScreenBody(username: username, id: id),
    );
  }
}

class StatusScreenBody extends StatefulWidget {
  final String username;
  final String id;

  const StatusScreenBody({Key? key, required this.username, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusScreenBodyState();
}

class _StatusScreenBodyState extends State<StatusScreenBody> {
  bool _loading = true;
  TweetStatus? _status;

  @override
  void initState() {
    super.initState();
    fetchTweet(widget.username, widget.id);
  }

  void fetchTweet(String username, String id) {
    setState(() {
      _loading = true;
    });

    var onError = (e, stackTrace) {
      log('Unable to load the tweet', error: e, stackTrace: stackTrace);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong loading the tweet! The error was: $e'),
        duration: Duration(days: 1),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => fetchTweet(username, id),
        ),
      ));
    };

    Twitter.getTweet(id)
        .then((status) {
          setState(() {
            _status = status;
          });
        })
        .catchError(onError)
        .whenComplete(() => setState(() {
              _loading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> comments = [];

    var status = _status;
    if (status == null) {
      return Center(child: CircularProgressIndicator());
    }

    var replies = status.replies;
    if (replies.isEmpty) {
      comments = [Text('No replies')];
    } else {
      comments = replies.map((e) {
        return TweetTile(clickable: true, currentUsername: widget.username, tweet: e);
      });
    }

    return SingleChildScrollView(
      child: LoadingStack(
        loading: _loading,
        child: Column(
          children: [
            TweetTile(currentUsername: widget.username, tweet: status.tweet, clickable: false),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [...comments],
              ),
            )
          ],
        ),
      ),
    );
  }
}