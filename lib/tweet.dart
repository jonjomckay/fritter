import 'dart:developer';

import 'package:auto_direction/auto_direction.dart';
import 'package:catcher/catcher.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/status.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/tweet/_card.dart';
import 'package:fritter/tweet/_content.dart';
import 'package:fritter/ui/futures.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'tweet/_media.dart';

class TweetTile extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final bool clickable;
  final String? currentUsername;
  final TweetWithCard? tweet;

  TweetTile({Key? key, required this.clickable, this.currentUsername, this.tweet}) : super(key: key);

  _createFooterIconButton(IconData icon, [Color? color, Function()? onPressed]) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(icon, size: 14, color: color),
      ),
      onTap: onPressed,
    );
  }

  _createFooterTextButton(IconData icon, String label, [Color? color, Function()? onPressed]) {
    return TextButton.icon(
      icon: Icon(icon, size: 14, color: color),
      onPressed: onPressed,
      label: Text(label, style: TextStyle(
        color: color,
        fontSize: 12.5
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.tweet == null) {
      return Container();
    }

    var numberFormat = NumberFormat.compact();

    TweetWithCard tweet = this.tweet!.retweetedStatusWithCard == null
      ? this.tweet!
      : this.tweet!.retweetedStatusWithCard!;

    Widget media = Container();
    if (tweet.extendedEntities?.media != null && tweet.extendedEntities!.media!.isNotEmpty) {
      media = TweetMedia(media: tweet.extendedEntities!.media!);
    }

    Widget retweetBanner = Container();
    if (this.tweet!.retweetedStatusWithCard != null) {
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

      if (tweet.quotedStatusWithCard != null) {
        quotedTweetTile = TweetTile(
          clickable: true,
          tweet: tweet.quotedStatusWithCard,
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
        child: Container(
          child: quotedTweetTile,
        ),
      );
    }

    Widget replyToTile = Container();

    var replyTo = tweet.inReplyToScreenName;
    if (replyTo != null) {
      replyToTile = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: RichText(
          text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.reply, size: 14, color: Theme.of(context).primaryColorDark),
                ),
                WidgetSpan(
                  child: SizedBox(width: 4)
                ),
                TextSpan(text: 'Replying to ', style: Theme.of(context).textTheme.caption),
                TextSpan(
                    text: '@$replyTo',
                    style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: replyTo)));
                    }
                )
              ]
          ),
        ),
      );
    }

    // Only create the tweet content if the tweet contains text
    Widget content = Container();
    if (tweet.displayTextRange![1] != 0) {
      content = Container(
        // Fill the width so both RTL and LTR text are displayed correctly
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: AutoDirection(
          text: tweetText,
          child: TweetContent(tweet: tweet),
        ),
      );
    }

    return Consumer<HomeModel>(builder: (context, model, child) => Card(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: retweetBanner,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  onTap: () {
                    // If the tweet is by the currently-viewed profile, don't allow clicks as it doesn't make sense
                    if (currentUsername != null && tweet.user!.screenName!.endsWith(currentUsername!)) {
                      return null;
                    }

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(username: tweet.user!.screenName!)));
                  },
                  title: Row(
                    children: [
                      Flexible(child: Text(tweet.user!.name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        )
                      )),
                      if (tweet.user!.verified ?? false)
                        SizedBox(width: 4),
                      if (tweet.user!.verified ?? false)
                        Icon(Icons.verified, size: 18, color: Theme.of(context).primaryColor)
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text('@${tweet.user!.screenName!}',
                        overflow: TextOverflow.ellipsis,
                      )),
                      SizedBox(width: 4),
                      Text(timeago.format(tweet.createdAt!),
                          style: Theme.of(context).textTheme.caption)
                    ],
                  ),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage: ExtendedNetworkImageProvider(tweet.user!.profileImageUrlHttps!.replaceAll('normal', '200x200'), cache: true),
                  ),
                ),
                replyToTile,
                content,
                media,
                quotedTweet,
                TweetCard(tweet: tweet, card: tweet.card),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Scrollbar(
                    controller: scrollController,
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: ButtonBar(
                        buttonTextTheme: ButtonTextTheme.accent,
                        buttonPadding: EdgeInsets.symmetric(horizontal: 0),
                        children: [
                          if (tweet.replyCount != null)
                            _createFooterTextButton(Icons.comment, numberFormat.format(tweet.replyCount), null, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => StatusScreen(username: tweet.user!.screenName!, id: tweet.idStr!)));
                            }),
                          if (tweet.retweetCount != null)
                            _createFooterTextButton(Icons.repeat, numberFormat.format(tweet.retweetCount)),
                          if (tweet.quoteCount != null)
                            _createFooterTextButton(Icons.message, numberFormat.format(tweet.quoteCount)),
                          if (tweet.favoriteCount != null)
                            _createFooterTextButton(Icons.favorite, numberFormat.format(tweet.favoriteCount)),
                          FutureBuilderWrapper<bool>(
                            future: model.isTweetSaved(tweet.idStr!),
                            onError: (error, stackTrace) => _createFooterIconButton(Icons.error, Colors.red, () async {
                              Catcher.reportCheckedError(error, stackTrace);
                            }),
                            onReady: (saved) {
                              if (saved) {
                                return _createFooterIconButton(Icons.bookmark, null, () async {
                                  await model.deleteSavedTweet(tweet.idStr!);
                                });
                              } else {
                                return _createFooterIconButton(Icons.bookmark_outline, null, () async {
                                  await model.saveTweet(tweet.idStr!, tweet.toJson());
                                });
                              }
                            },
                          ),
                          _createFooterIconButton(Icons.share, null, () async {
                            var createShareDialogItem = (String text, String shareContent) => SimpleDialogOption(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Text(text, style: TextStyle(
                                    fontSize: 16
                                )),
                              ),
                              onPressed: () => Share.share(shareContent),
                            );

                            showDialog(context: context, builder: (context) {
                              return SimpleDialog(
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                                children: [
                                  createShareDialogItem('Share tweet content', tweetText),
                                  createShareDialogItem('Share tweet link', 'https://twitter.com/${tweet.user!.screenName}/status/${tweet.idStr}'),
                                ],
                              );
                            });
                          })
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
