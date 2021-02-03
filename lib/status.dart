import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/models.dart';
import 'package:fritter/tweet.dart';

class StatusScreen extends StatefulWidget {
  final String username;
  final String id;

  const StatusScreen({Key key, this.username, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  bool _loading = true;
  Tweet _status = Tweet.emptyTweet();

  @override
  void initState() {
    super.initState();

    setState(() {
      _loading = true;
    });

    TwitterClient.getStatus(widget.username, widget.id).then((status) {
      setState(() {
        _loading = false;
        _status = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> comments = [];
    if (_status != null) {
      if (_status.comments.isEmpty) {
        comments = [Text('No replies')];
      } else {
        comments = _status.comments.map((e) {
          return TweetTile(currentUsername: widget.username, tweet: e);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: LoadingStack(
          loading: _loading,
          child: Column(
            children: [
              TweetTile(currentUsername: widget.username, tweet: _status),
              Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [...comments],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}