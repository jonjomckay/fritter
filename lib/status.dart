import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
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
  Tweet _status;

  @override
  void initState() {
    super.initState();

    TwitterClient.getStatus(widget.username, widget.id).then((status) {
      setState(() {
        _status = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_status == null) {
      child = Center();
    } else {
      Iterable<Widget> comments = _status.comments.map((e) {
        return TweetTile(currentUsername: widget.username, tweet: e);
      });

      if (comments.isEmpty) {
        comments = [Text('No replies')];
      }

      child = SingleChildScrollView(
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
      );
    };

    return Scaffold(
      appBar: AppBar(),
      body: child,
    );
  }

}