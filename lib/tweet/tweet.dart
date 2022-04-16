import 'package:auto_direction/auto_direction.dart';
import 'package:catcher/catcher.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/status.dart';
import 'package:fritter/tweet/_card.dart';
import 'package:fritter/tweet/_entities.dart';
import 'package:fritter/tweet/_media.dart';
import 'package:fritter/tweet/tweet_exceptions.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:fritter/user.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:fritter/utils/misc.dart';
import 'package:fritter/utils/translation.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class TweetTile extends StatefulWidget {
  final bool clickable;
  final String? currentUsername;
  final TweetWithCard tweet;
  final bool isPinned;
  final bool isThread;

  const TweetTile(
      {Key? key,
      required this.clickable,
      this.currentUsername,
      required this.tweet,
      this.isPinned = false,
      this.isThread = false})
      : super(key: key);

  @override
  TweetTileState createState() => TweetTileState();
}

class TweetTileState extends State<TweetTile> with SingleTickerProviderStateMixin {
  static final log = Logger('TweetTile');

  final ScrollController scrollController = ScrollController();
  late final bool clickable;
  late final String? currentUsername;
  late final TweetWithCard tweet;
  late final bool isPinned;
  late final bool isThread;

  TranslationStatus _translationStatus = TranslationStatus.original;

  List<TweetTextPart> _originalParts = [];
  List<TweetTextPart> _displayParts = [];
  List<TweetTextPart> _translatedParts = [];

  String? _convertRunesToText(Iterable<int> runes, int start, [int? end]) {
    var string = runes.getRange(start, end).map((e) => String.fromCharCode(e)).join('');
    if (string.isEmpty) {
      return null;
    }

    return HtmlUnescape().convert(string);
  }

  List<TweetEntity> _populateEntities(
      {required List<TweetEntity> entities, List<dynamic>? source, required Function getNewEntity}) {
    source = source ?? [];

    for (dynamic newEntity in source) {
      entities.add(getNewEntity(newEntity));
    }

    return entities;
  }

  List<TweetEntity> _getEntities() {
    List<TweetEntity> entities = [];

    entities = _populateEntities(
        entities: entities,
        source: tweet.entities?.hashtags,
        getNewEntity: (Hashtag hashtag) {
          return TweetHashtag(hashtag, () async {
            await showSearch(context: context, delegate: TweetSearchDelegate(initialTab: 1), query: '#${hashtag.text}');
          });
        });

    entities = _populateEntities(
        entities: entities,
        source: tweet.entities?.userMentions,
        getNewEntity: (UserMention mention) {
          return TweetUserMention(mention, () {
            Navigator.pushNamed(context, routeProfile, arguments: mention.screenName!);
          });
        });

    entities = _populateEntities(
        entities: entities,
        source: tweet.entities?.urls,
        getNewEntity: (Url url) {
          return TweetUrl(url, () async {
            String? uri = url.expandedUrl;
            if (uri == null) {
              return;
            }

            await launch(uri);
          });
        });

    entities.sort((a, b) => a.getEntityStart().compareTo(b.getEntityStart()));

    return entities;
  }

  Future<void> onClickTranslate() async {
    // If we've already translated this text before, use those results instead of translating again
    if (_translatedParts.isNotEmpty) {
      return setState(() {
        _displayParts = _translatedParts;
        _translationStatus = TranslationStatus.translated;
      });
    }

    setState(() {
      _translationStatus = TranslationStatus.translating;
    });

    try {
      var systemLocale = getShortSystemLocale();

      var isLanguageSupported = await isLanguageSupportedForTranslation(systemLocale);
      if (!isLanguageSupported) {
        return showTranslationError('Your system language ($systemLocale) is not supported for translation');
      }
    } catch (e, stackTrace) {
      log.severe('Unable to list the supported languages');
      Catcher.reportCheckedError(e, stackTrace);

      return showTranslationError(
          'Failed to get the list of supported languages. Please check your connection, or try again later!');
    }

    var originalText = _originalParts.map((e) => e.toString()).toList();

    var res = await TranslationAPI.translate(tweet.idStr!, originalText, tweet.lang ?? "");
    if (res.success) {
      var translatedParts = convertTextPartsToTweetEntities(List.from(res.body['translatedText']));

      // We cache the translated parts in a property in case the user swaps back and forth
      return setState(() {
        _displayParts = translatedParts;
        _translatedParts = translatedParts;
        _translationStatus = TranslationStatus.translated;
      });
    } else {
      return showTranslationError(res.errorMessage ?? 'An unknown error occurred while translating');
    }
  }

  void showTranslationError(String message) {
    setState(() {
      _translationStatus = TranslationStatus.translationFailed;
    });

    showSnackBar(context, icon: '💥', message: message);
  }

  Future<void> onClickShowOriginal() async {
    setState(() {
      _displayParts = _originalParts;
      _translationStatus = TranslationStatus.original;
    });
  }

  List<TweetTextPart> convertTextPartsToTweetEntities(List<String> parts) {
    List<TweetTextPart> translatedParts = [];

    for (var i = 0; i < parts.length; i++) {
      var thing = _originalParts[i];
      if (thing.plainText != null) {
        translatedParts.add(TweetTextPart(null, parts[i]));
      } else {
        translatedParts.add(TweetTextPart(thing.entity, null));
      }
    }

    return translatedParts;
  }

  @override
  void initState() {
    super.initState();

    clickable = widget.clickable;
    currentUsername = widget.currentUsername;
    tweet = widget.tweet;
    isPinned = widget.isPinned;
    isThread = widget.isThread;

    // Generate all the tweet entities (mentions, hashtags, etc.) from the tweet text
    Runes tweetText = Runes(tweet.fullText ?? tweet.text!);

    // If we're not given a text display range, we just display the entire text
    List<int> displayTextRange = tweet.displayTextRange ?? [0, tweetText.length];

    Iterable<int> runes = tweetText.getRange(displayTextRange[0], displayTextRange[1]);

    List<TweetEntity> entities = _getEntities();
    List<TweetTextPart> things = [];

    int index = 0;

    for (var part in entities) {
      // Generate new indices for the entity start and end, by subtracting the displayTextRange's start index, as we ignore text up until that point
      int start = part.getEntityStart() - displayTextRange[0];
      int end = part.getEntityEnd() - displayTextRange[0];

      // Only add entities that are after the displayTextRange's start index
      if (start < 0) {
        continue;
      }

      // Add any text between the last entity's end and the start of this one
      var textPart = _convertRunesToText(runes, index, start);
      if (textPart != null) {
        things.add(TweetTextPart(null, textPart));
      }

      // Then add the actual entity
      things.add(TweetTextPart(part.getContent(), null));
      // parts.add(part.getContent());

      // Then set our index in the tweet text as the end of our entity
      index = end;
    }

    var textPart = _convertRunesToText(runes, index);
    if (textPart != null) {
      things.add(TweetTextPart(null, textPart));
    }

    setState(() {
      _displayParts = things;
      _originalParts = things;
    });
  }

  _createFooterIconButton(IconData icon, [Color? color, Function()? onPressed]) {
    return TextButton.icon(
      icon: Icon(icon, size: 14, color: color),
      onPressed: onPressed,
      label: Container(),
    );
  }

  _createFooterTextButton(IconData icon, String label, [Color? color, Function()? onPressed]) {
    return TextButton.icon(
      icon: Icon(icon, size: 14, color: color),
      onPressed: onPressed,
      label: Text(label, style: TextStyle(color: color, fontSize: 12.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat.compact();

    TweetWithCard tweet = this.tweet.retweetedStatusWithCard == null ? this.tweet : this.tweet.retweetedStatusWithCard!;

    if (tweet.isTombstone ?? false) {
      return SizedBox(
        width: double.infinity,
        child: Card(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(tweet.text!, style: const TextStyle(fontStyle: FontStyle.italic))),
        ),
      );
    }

    Widget media = Container();
    if (tweet.extendedEntities?.media != null && tweet.extendedEntities!.media!.isNotEmpty) {
      media = TweetMedia(media: tweet.extendedEntities!.media!, username: this.tweet.user!.screenName!);
    }

    Widget retweetBanner = Container();
    Widget retweetSidebar = Container();
    if (this.tweet.retweetedStatusWithCard != null) {
      retweetBanner = _TweetTileLeading(
        icon: Icons.repeat,
        children: [
          TextSpan(
              text: L10n.of(context).this_tweet_user_name_retweeted(this.tweet.user!.name!),
              style: Theme.of(context).textTheme.caption)
        ],
      );

      retweetSidebar = Container(color: Theme.of(context).secondaryHeaderColor, width: 4);
    }

    Widget replyToTile = Container();
    var replyTo = tweet.inReplyToScreenName;
    if (replyTo != null) {
      replyToTile = _TweetTileLeading(
        onTap: () {
          var replyToId = tweet.inReplyToStatusIdStr;
          if (replyToId == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                L10n.of(context).sorry_the_replied_tweet_could_not_be_found,
              ),
            ));
          } else {
            Navigator.pushNamed(context, routeStatus,
                arguments: StatusScreenArguments(id: replyToId, username: replyTo));
          }
        },
        icon: Icons.reply,
        children: [
          TextSpan(text: '${L10n.of(context).replying_to} ', style: Theme.of(context).textTheme.caption),
          TextSpan(
              text: '@$replyTo', style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold)),
        ],
      );
    }

    var tweetText = tweet.fullText ?? tweet.text;
    if (tweetText == null) {
      Catcher.reportCheckedError('The tweet ${tweet.idStr} did not contain any text. This is unexpected', null);

      return Text(L10n.of(context).the_tweet_did_not_contain_any_text_this_is_unexpected);
    }

    var quotedTweet = Container();
    if (tweet.isQuoteStatus ?? false) {
      Widget quotedTweetTile;

      if (tweet.quotedStatusWithCard != null) {
        quotedTweetTile = TweetTile(
          clickable: true,
          tweet: tweet.quotedStatusWithCard!,
          currentUsername: currentUsername,
        );
      } else {
        quotedTweetTile = Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            L10n.of(context).this_tweet_is_unavailable,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        );
      }

      quotedTweet = Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(8),
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: AutoDirection(
            text: tweetText,
            child: SelectableText.rich(
              TextSpan(children: [
                ..._displayParts.map((e) {
                  if (e.plainText != null) {
                    return TextSpan(text: e.plainText);
                  } else {
                    return e.entity!;
                  }
                })
              ]),
            )),
      );
    }

    Widget translateButton;
    switch (_translationStatus) {
      case TranslationStatus.original:
        translateButton = _createFooterIconButton(Icons.translate, Colors.blue, () async => onClickTranslate());
        break;
      case TranslationStatus.translating:
        translateButton = const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
        );
        break;
      case TranslationStatus.translationFailed:
        translateButton = _createFooterIconButton(Icons.translate, Colors.red, () async => onClickTranslate());
        break;
      case TranslationStatus.translated:
        translateButton = _createFooterIconButton(Icons.translate, Colors.green, () async => onClickShowOriginal());
        break;
    }

    DateTime? createdAt;
    if (tweet.createdAt != null) {
      createdAt = tweet.createdAt;
    } else {
      // Report an error if we're missing the creation date for some reason
      Catcher.reportCheckedError(TweetMissingDataException(tweet.idStr, ['createdAt']), null);
    }

    return Consumer<HomeModel>(
        builder: (context, model, child) => Card(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    retweetSidebar,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        retweetBanner,
                        replyToTile,
                        if (isPinned)
                          _TweetTileLeading(icon: Icons.push_pin, children: [
                            TextSpan(
                              text: L10n.of(context).pinned_tweet,
                              style: Theme.of(context).textTheme.caption,
                            )
                          ]),
                        if (isThread)
                          _TweetTileLeading(icon: Icons.forum, children: [
                            TextSpan(
                              text: L10n.of(context).thread,
                              style: Theme.of(context).textTheme.caption,
                            )
                          ]),
                        ListTile(
                          onTap: () {
                            // If the tweet is by the currently-viewed profile, don't allow clicks as it doesn't make sense
                            if (currentUsername != null && tweet.user!.screenName!.endsWith(currentUsername!)) {
                              return;
                            }

                            Navigator.pushNamed(context, routeProfile, arguments: tweet.user!.screenName!);
                          },
                          title: Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Flexible(
                                        child: Text(tweet.user!.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.w500))),
                                    if (tweet.user!.verified ?? false) const SizedBox(width: 4),
                                    if (tweet.user!.verified ?? false)
                                      Icon(Icons.verified, size: 18, color: Theme.of(context).primaryColor)
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_horiz),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minHeight: 32),
                                onPressed: () async {
                                  var createSheetButton = (title, icon, onTap) => ListTile(
                                        onTap: onTap,
                                        leading: Icon(icon),
                                        title: Text(title),
                                      );

                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SafeArea(
                                            child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FutureBuilderWrapper<bool>(
                                              future: model.isTweetSaved(tweet.idStr!),
                                              onError: (error, stackTrace) =>
                                                  _createFooterIconButton(Icons.error, Colors.red, () async {
                                                Catcher.reportCheckedError(error, stackTrace);
                                              }),
                                              onReady: (saved) {
                                                if (saved) {
                                                  return createSheetButton(
                                                    L10n.of(context).unsave,
                                                    Icons.bookmark,
                                                    () async {
                                                      await model.deleteSavedTweet(tweet.idStr!);
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                } else {
                                                  return createSheetButton(
                                                      L10n.of(context).save, Icons.bookmark_outline, () async {
                                                    await model.saveTweet(tweet.idStr!, tweet.toJson());
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              },
                                            ),
                                            createSheetButton(
                                              L10n.of(context).share_tweet_content,
                                              Icons.share,
                                              () async {
                                                Share.share(tweetText);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            createSheetButton(L10n.of(context).share_tweet_link, Icons.share, () async {
                                              Share.share(
                                                  'https://twitter.com/${tweet.user!.screenName}/status/${tweet.idStr}');
                                              Navigator.pop(context);
                                            }),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                              child: Divider(
                                                thickness: 1.0,
                                              ),
                                            ),
                                            createSheetButton(
                                              L10n.of(context).cancel,
                                              Icons.close,
                                              () => Navigator.pop(context),
                                            )
                                          ],
                                        ));
                                      });
                                },
                              )
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                '@${tweet.user!.screenName!}',
                                overflow: TextOverflow.ellipsis,
                              )),
                              const SizedBox(width: 4),
                              if (createdAt != null)
                                Text(timeago.format(createdAt, locale: Intl.shortLocale(Intl.getCurrentLocale())),
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
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ButtonBar(
                            buttonTextTheme: ButtonTextTheme.accent,
                            buttonPadding: const EdgeInsets.symmetric(horizontal: 0),
                            children: [
                              if (tweet.replyCount != null)
                                _createFooterTextButton(Icons.comment, numberFormat.format(tweet.replyCount), null, () {
                                  Navigator.pushNamed(context, routeStatus,
                                      arguments:
                                          StatusScreenArguments(id: tweet.idStr!, username: tweet.user!.screenName!));
                                }),
                              if (tweet.retweetCount != null)
                                _createFooterTextButton(Icons.repeat, numberFormat.format(tweet.retweetCount)),
                              if (tweet.quoteCount != null)
                                _createFooterTextButton(Icons.message, numberFormat.format(tweet.quoteCount)),
                              if (tweet.favoriteCount != null)
                                _createFooterTextButton(Icons.favorite, numberFormat.format(tweet.favoriteCount)),
                              translateButton,
                            ],
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
      margin: const EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 0, left: 52, right: 16, top: 0),
          child: RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  child: Icon(icon, size: 12, color: Theme.of(context).hintColor),
                  alignment: PlaceholderAlignment.middle),
              const WidgetSpan(child: SizedBox(width: 16)),
              ...children
            ]),
          ),
        ),
      ),
    );
  }
}

class TweetTextPart {
  final InlineSpan? entity;
  String? plainText;

  TweetTextPart(this.entity, this.plainText);

  @override
  String toString() {
    return plainText ?? '';
  }
}

enum TranslationStatus { original, translating, translationFailed, translated }
