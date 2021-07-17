import 'package:auto_direction/auto_direction.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/status.dart';
import 'package:fritter/profile/profile.dart';
import 'package:fritter/tweet/_card.dart';
import 'package:fritter/tweet/_content.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

import '_media.dart';

class TweetTile extends StatelessWidget {
  static final log = Logger('TweetTile');

  final ScrollController scrollController = ScrollController();
  final bool clickable;
  final String? currentUsername;
  final TweetWithCard? tweet;
  final bool isPinned;
  final bool isThread;

  TweetTile({Key? key, required this.clickable, this.currentUsername, this.tweet, this.isPinned = false, this.isThread = false}) : super(key: key);

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

    if (tweet.isTombstone ?? false) {
      return Container(
        width: double.infinity,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(tweet.text!, style: TextStyle(
              fontStyle: FontStyle.italic
            ))
          ),
        ),
      );
    }

    Widget media = Container();
    if (tweet.extendedEntities?.media != null && tweet.extendedEntities!.media!.isNotEmpty) {
      media = TweetMedia(media: tweet.extendedEntities!.media!);
    }

    Widget retweetBanner = Container();
    Widget retweetSidebar = Container();
    if (this.tweet!.retweetedStatusWithCard != null) {
      retweetBanner = _TweetTileLeading(
        icon: Icons.repeat,
        children: [
          TextSpan(
              text: '${this.tweet!.user!.name!} retweeted',
              style: Theme.of(context).textTheme.caption
          )
        ],
      );

      retweetSidebar = Container(
          color: Theme.of(context).secondaryHeaderColor,
          width: 4
      );
    }

    Widget replyToTile = Container();
    var replyTo = tweet.inReplyToScreenName;
    if (replyTo != null) {
      replyToTile = _TweetTileLeading(
        onTap: () {
          var replyToId = tweet.inReplyToStatusIdStr;
          if (replyToId == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Sorry, the replied tweet could not be found!'),
            ));
          } else {
            Navigator.pushNamed(context, ROUTE_STATUS, arguments: StatusScreenArguments(
                id: replyToId,
                username: replyTo
            ));
          }
        },
        icon: Icons.reply,
        children: [
          TextSpan(text: 'Replying to ', style: Theme.of(context).textTheme.caption),
          TextSpan(
              text: '@$replyTo',
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontWeight: FontWeight.bold
              )
          ),
        ],
      );
    }

    var tweetText = tweet.fullText == null
        ? tweet.text
        : tweet.fullText;

    if (tweetText == null) {
      var message = 'The tweet did not contain any text. This is unexpected';

      log.severe(message);

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
            retweetSidebar,
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                retweetBanner,
                replyToTile,
                if (isPinned)
                  _TweetTileLeading(
                    icon: Icons.push_pin,
                    children: [
                      TextSpan(
                          text: 'Pinned tweet',
                          style: Theme.of(context).textTheme.caption
                      )
                    ]
                  ),
                if (isThread)
                  _TweetTileLeading(
                    icon: Icons.forum,
                    children: [
                      TextSpan(
                          text: 'Thread',
                          style: Theme.of(context).textTheme.caption
                      )
                    ]
                  ),
                ListTile(
                  onTap: () {
                    // If the tweet is by the currently-viewed profile, don't allow clicks as it doesn't make sense
                    if (currentUsername != null && tweet.user!.screenName!.endsWith(currentUsername!)) {
                      return null;
                    }

                    Navigator.pushNamed(context, ROUTE_PROFILE, arguments: tweet.user!.screenName!);
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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(64),
                    child: UserAvatar(uri: tweet.user!.profileImageUrlHttps),
                  ),
                ),
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
                              Navigator.pushNamed(context, ROUTE_STATUS, arguments: StatusScreenArguments(
                                  id: tweet.idStr!,
                                  username: tweet.user!.screenName!
                              ));
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
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}

class _TweetTileLeading extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final Iterable<InlineSpan> children;

  const _TweetTileLeading({Key? key, this.onTap, required this.icon, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 0, left: 52, right: 16, top: 0),
          child: Container(
            child: RichText(
              text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(icon, size: 12, color: Theme.of(context).hintColor),
                        alignment: PlaceholderAlignment.middle
                    ),
                    WidgetSpan(
                        child: SizedBox(width: 16)
                    ),
                    ...children
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}