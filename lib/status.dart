import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/loading.dart';
import 'package:fritter/models.dart';
import 'package:fritter/tweet.dart';

class StatusScreen extends StatelessWidget {
  final String username;
  final String id;

  const StatusScreen({Key key, this.username, this.id}) : super(key: key);

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

  const StatusScreenBody({Key key, this.username, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusScreenBodyState();
}

class _StatusScreenBodyState extends State<StatusScreenBody> {
  bool _loading = true;
  Tweet _status;

  @override
  void initState() {
    super.initState();
    fetchTweet(widget.username, widget.id);
  }

  void fetchTweet(String username, String id) {
    setState(() {
      _loading = true;
    });

    TwitterClient.getStatus(username, id)
        .then((status) => setState(() {
              _status = status;
            }))
        .catchError((e) => Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Something went wrong loading the tweet! The error was: $e'),
              duration: Duration(days: 1),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () => fetchTweet(username, id),
              ),
            )))
        .whenComplete(() => setState(() {
              _loading = false;
            }));
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

    return SingleChildScrollView(
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
    );
  }
}