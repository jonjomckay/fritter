import 'package:auto_direction/auto_direction.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:fritter/models.dart';
import 'package:flutter/material.dart';
import 'package:fritter/status.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'profile.dart';

class TweetVideo extends StatefulWidget {
  final bool loop;
  final String uri;

  const TweetVideo({Key key, this.loop, this.uri}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo> {
  BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.uri);

    var configuration = BetterPlayerConfiguration(autoDetectFullscreenDeviceOrientation: true, looping: widget.loop);

    _controller = BetterPlayerController(configuration, betterPlayerDataSource: dataSource);
    _controller.addEventsListener((e) {
      if (e.betterPlayerEventType == BetterPlayerEventType.initialized) {
        setState(() {
          _controller.setOverriddenAspectRatio(_controller.videoPlayerController.value.aspectRatio);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.isPlaying()
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: BetterPlayer(controller: _controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class TweetTile extends StatelessWidget {
  final bool clickable;
  final String currentUsername;
  final Tweet tweet;

  const TweetTile({Key key, this.clickable, this.currentUsername, this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tweet == null) {
      return Container();
    }

    var numberFormat = NumberFormat.compact();

    var attachments = tweet.attachments.map((e) {
      if (e.type == 'animated_gif') {
        return TweetVideo(uri: e.src, loop: true);
      }

      if (e.type == 'video') {
        return TweetVideo(uri: e.src);
      }

      if (e.type == 'photo') {
        return Image.network(e.src);
      }

      return Text('Unknown');
    });

    Widget retweetBanner = Container();
    if (tweet.retweet) {
      retweetBanner = ColoredBox(
          color: Theme.of(context).secondaryHeaderColor,
          child: Center(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.repeat, size: 14, color: Theme.of(context).primaryColorDark),
                        ),
                        // TextSpan(
                        //   text: ' Retweeted',
                        // ),
                      ],
                    )
                )
            ),
          )
      );
    }

    return Builder(builder: (context) {
      List<InlineSpan> contentWidgets = [];

      // Split the string by any mentions, and turn those mentions into links to the profile
      tweet.content.splitMapJoin(RegExp(r'\B\@([\w\-]+)'),
          onMatch: (match) {
            var username = match.group(1);

            contentWidgets.add(TextSpan(
                text: '@$username',
                style: TextStyle(color: Theme.of(context).accentColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: username)));
                  }
            ));

            return username;
          },
          onNonMatch: (text) {
            contentWidgets.add(TextSpan(
                text: text
            ));

            return text;
          }
      );

      return Card(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  retweetBanner,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            // If the tweet is by the currently-viewed profile, don't allow clicks as it doesn't make sense
                            if (currentUsername != null && tweet.userUsername.endsWith(currentUsername)) {
                              return null;
                            }

                            return Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: tweet.userUsername)));
                          },
                          title: Text(tweet.userFullName,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(tweet.userUsername),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(tweet.userAvatar),
                          ),
                          trailing: Text(timeago.format(tweet.date),
                              style: Theme.of(context).textTheme.caption),
                        ),
                        GestureDetector(
                          onTap: () {
                            var a = Uri.parse(tweet.link);
                            var username = a.pathSegments[0];
                            var statusId = a.pathSegments[2];

                            if (clickable) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StatusScreen(username: username, id: statusId)));
                            }

                            return null;
                          },
                          child: Container(
                            // Fill the width so both RTL and LTR text are displayed correctly
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            child: AutoDirection(
                              text: tweet.content,
                              child: RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.subtitle1,
                                    children: contentWidgets
                                ),
                              ),
                            ),
                          ),
                        ),
                        ...attachments,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              buttonTextTheme: ButtonTextTheme.accent,
              children: [
                FlatButton.icon(
                  icon: Icon(Icons.comment, size: 20),
                  onPressed: null,
                  label: Text(numberFormat.format(tweet.numberOfComments)),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.repeat, size: 20),
                  onPressed: null,
                  label: Text(numberFormat.format(tweet.numberOfRetweets)),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.message, size: 20),
                  onPressed: null,
                  label: Text(numberFormat.format(tweet.numberOfQuotes)),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.favorite, size: 20),
                  onPressed: null,
                  label: Text(numberFormat.format(tweet.numberOfLikes)),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}