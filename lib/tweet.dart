import 'dart:developer';

import 'package:auto_direction/auto_direction.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/status.dart';
import 'package:fritter/tweet/_content.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

import 'profile.dart';

class TweetVideo extends StatefulWidget {
  final bool loop;
  final String uri;

  const TweetVideo({Key? key, required this.loop, required this.uri}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.uri);
    _controller.setLooping(widget.loop);
    _controller.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});
    });
  }

  Widget _createControls() {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: _controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      // TODO: Replace this with the information from the API
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller),
            _createControls(),
          ],
        ),
      ),
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
  final String? currentUsername;
  final Tweet? tweet;

  const TweetTile({Key? key, required this.clickable, this.currentUsername, this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.tweet == null) {
      return Container();
    }

    var numberFormat = NumberFormat.compact();

    Tweet tweet = this.tweet!.retweetedStatus == null
      ? this.tweet!
      : this.tweet!.retweetedStatus!;

    var attachments = (tweet.extendedEntities?.media ?? []).map((e) {
      if (e.type == 'animated_gif') {
        return TweetVideo(uri: e.videoInfo!.variants![0].url!, loop: true);
      }

      if (e.type == 'video') {
        return TweetVideo(uri: e.videoInfo!.variants![0].url!, loop: false);
      }

      if (e.type == 'photo') {
        return ExtendedImage.network(e.mediaUrlHttps!, cache: true);
      }

      return Text('Unknown');
    });

    Widget retweetBanner = Container();
    if (this.tweet!.retweetedStatus != null) {
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
                      ],
                    )
                )
            ),
          )
      );
    }

    return Builder(builder: (context) {
      var tweetText = tweet.fullText == null
          ? tweet.text
          : tweet.fullText;

      if (tweetText == null) {
        var message = 'The tweet did not contain any text. This is unexpected';

        log(message);

        return Container(child: Text(
            'The tweet did not contain any text. This is unexpected'
        ));
      }

      var quotedTweet = Container();
      if (tweet.isQuoteStatus ?? false) {
        Widget quotedTweetTile;

        if (tweet.quotedStatus != null) {
          quotedTweetTile = TweetTile(
            clickable: true,
            tweet: tweet.quotedStatus,
            currentUsername: tweet.user?.screenName,
          );
        } else {
          quotedTweetTile = Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('This tweet is unavailable', style: TextStyle(
                color: Theme.of(context).hintColor
            )),
          );
        }

        quotedTweet = Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8)
          ),
          margin: EdgeInsets.all(8),
          child: quotedTweetTile,
        );
      }

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
                            if (currentUsername != null && tweet.user!.screenName!.endsWith(currentUsername!)) {
                              return null;
                            }

                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(id: tweet.user!.idStr, username: tweet.user!.screenName!)));
                          },
                          title: Text(tweet.user!.name!,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(tweet.user!.screenName!),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundImage: ExtendedNetworkImageProvider(tweet.user!.profileImageUrlHttps!.replaceAll('normal', '200x200'), cache: true),
                          ),
                          trailing: Text(timeago.format(tweet.createdAt!),
                              style: Theme.of(context).textTheme.caption),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (clickable) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StatusScreen(username: tweet.user!.screenName!, id: tweet.idStr!)));
                            }

                            return null;
                          },
                          child: Container(
                            // Fill the width so both RTL and LTR text are displayed correctly
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: AutoDirection(
                              text: tweetText,
                              child: TweetContent(
                                text: tweetText,
                                urls: tweet.entities?.urls ?? [],
                                mentions: tweet.entities?.userMentions ?? [],
                                hashtags: tweet.entities?.hashtags ?? []
                              ),
                            ),
                          ),
                        ),
                        ...attachments,
                        quotedTweet,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (tweet.replyCount != null)
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonTextTheme: ButtonTextTheme.accent,
                buttonPadding: EdgeInsets.symmetric(horizontal: 6),
                children: [
                  FlatButton.icon(
                    icon: Icon(Icons.comment, size: 16),
                    onPressed: null,
                    label: Text(numberFormat.format(tweet.replyCount)),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.repeat, size: 16),
                    onPressed: null,
                    label: Text(numberFormat.format(tweet.retweetCount)),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.message, size: 16),
                    onPressed: null,
                    label: Text(numberFormat.format(tweet.quoteCount)),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.favorite, size: 16),
                    onPressed: null,
                    label: Text(numberFormat.format(tweet.favoriteCount)),
                  ),
                ],
              )
          ],
        ),
      );
    });
  }
}