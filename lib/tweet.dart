import 'package:auto_direction/auto_direction.dart';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/status.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'profile.dart';

class TweetVideo extends StatefulWidget {
  final bool loop;
  final String uri;

  const TweetVideo({Key? key, required this.loop, required this.uri}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo> {
  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.uri);

    var configuration = BetterPlayerConfiguration(autoDetectFullscreenDeviceOrientation: true, looping: widget.loop);

    _controller = BetterPlayerController(configuration, betterPlayerDataSource: dataSource);
    _controller.addEventsListener((e) {
      if (e.betterPlayerEventType == BetterPlayerEventType.initialized) {
        // TODO: Replace this with the information from the API
        setState(() {
          _controller.setOverriddenAspectRatio(_controller.videoPlayerController!.value.aspectRatio);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_controller.isPlaying() ?? false)
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
  final String? currentUsername;
  final Tweet? tweet;

  const TweetTile({Key? key, required this.clickable, this.currentUsername, this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tweet = this.tweet;
    if (tweet == null) {
      return Container();
    }

    var numberFormat = NumberFormat.compact();

    var attachments = (tweet.extendedEntities?.media ?? []).map((e) {
      if (e.type == 'animated_gif') {
        return TweetVideo(uri: e.videoInfo!.variants![0].url!, loop: true);
      }

      if (e.type == 'video') {
        return TweetVideo(uri: e.videoInfo!.variants![0].url!, loop: false);
      }

      if (e.type == 'photo') {
        return CachedNetworkImage(imageUrl: e.mediaUrlHttps!);
      }

      return Text('Unknown');
    });

    Widget retweetBanner = Container();
    if (tweet.retweeted ?? false) {
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

      var tweetText = tweet.fullText == null
        ? tweet.text
        : tweet.fullText;

      if (tweetText == null) {
        var message = 'The tweet did not contain any text. This is unexpected';

        print(message);

        return Container(child: Text(
            'The tweet did not contain any text. This is unexpected'
        ));
      }

      // Split the string by any mentions, and turn those mentions into links to the profile
      tweetText.splitMapJoin(RegExp(r'\B\@([\w\-]+)'),
          onMatch: (match) {
            var username = match.group(1) ?? '';

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

      var quotedTweet = Container();
      if (tweet.quotedStatus != null) {
        quotedTweet = Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(8)
          ),
          margin: EdgeInsets.all(8),
          child: TweetTile(
            clickable: true,
            tweet: tweet.quotedStatus,
            currentUsername: tweet.user?.screenName,
          ),
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
                            backgroundImage: CachedNetworkImageProvider(tweet.user!.profileImageUrlHttps!.replaceAll('normal', '200x200')),
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