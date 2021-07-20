import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/utils/misc.dart';
import 'package:fritter/utils/translation_api.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class TweetEntity {
  List<int>? indices;

  TweetEntity(this.indices);

  InlineSpan getContent();

  int getEntityStart() {
    return indices![0];
  }

  int getEntityEnd() {
    return indices![1];
  }
}

class TweetHashtag extends TweetEntity {
  final Hashtag hashtag;
  final Function onTap;

  TweetHashtag(this.hashtag, this.onTap): super(hashtag.indices);

  @override
  InlineSpan getContent() {
    return TextSpan(
        text: '#${hashtag.text}',
        style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTap = () {
          onTap();
        }
    );
  }
}

class TweetUserMention extends TweetEntity {
  final UserMention mention;
  final Function onTap;

  TweetUserMention(this.mention, this.onTap): super(mention.indices);

  @override
  InlineSpan getContent() {
    return TextSpan(
        text: '@${mention.screenName}',
        style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTap = () {
          onTap();
        }
    );
  }
}

class TweetUrl extends TweetEntity {
  final Url url;
  final Function onTap;

  TweetUrl(this.url, this.onTap): super(url.indices);

  @override
  InlineSpan getContent() {
    return TextSpan(
        text: url.displayUrl,
        style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTap = () {
          onTap();
        }
    );
  }
}

extension IterableRange<T> on Iterable<T> {
  Iterable<T> getRange(int start, [int? end]) {
    return (end != null ? this.take(end) : this).skip(start);
  }
}

class TweetContent extends StatefulWidget {
  final Tweet tweet;

  TweetContent({ key, required this.tweet }): super(key: key);

  TweetContentState createState() => TweetContentState(tweet: tweet);
}

class TweetContentState extends State {
  final Tweet tweet;

  bool translate = false;

  SelectableText? result;

  TweetContentState({ required this.tweet }): super();

  _addText(List<InlineSpan> parts,Iterable<int> runes, TranslationAPI? translationAPI, int start, [int? end]) async {
    var string = runes.getRange(start, end).map((e) => String.fromCharCode(e)).join('');
    if (string.isEmpty) {
      return;
    }

    var htmlUnescape = HtmlUnescape();

    String text = htmlUnescape.convert(string);

    if (this.translate == true && translationAPI != null) {
      var res = await translationAPI.translate(text, tweet.lang ?? "");

      if(res.code == 200) {
        text = res.body["translatedText"];
      }
      else {
        String message = "";

        switch(res.code) {
          case 400:
            RegExp languageNotSupported = new RegExp(r"^\w+\ is\ not\ supported$");

            message = (languageNotSupported.hasMatch(res.body["error"])
              ? "Error: language "
              : "Error: "
            ) + res.body["error"];
            break;
          case 403:
            message = "Error: Banned from translation API";
            break;
          case 429:
            message = "Error: Sending too many frequent translation requests";
            break;
          case 500:
            message = "Error: The translation API failed to translate the tweet";
            break;
        }

        await Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
      }
    }
    
    parts.add(TextSpan(text: text, style: Theme.of(context).textTheme.bodyText2));
  }

  List<TweetEntity> _populateEntities({required List<TweetEntity> entities, List<dynamic>? source, required Function getNewEntity}) {
    source = source ?? [];

    for(dynamic newEntity in source) {
      entities.add(getNewEntity(newEntity));
    }

    return entities;
  }

  void setTranslate(bool translate) {
    setState(() {
      this.translate = translate;
    });
  }

  List<TweetEntity> _getEntities() {
    List<TweetEntity> entities = [];

    entities = _populateEntities(entities: entities, source: tweet.entities?.hashtags, getNewEntity: (Hashtag hashtag) {
      return TweetHashtag(hashtag, () async {
        await showSearch(
            context: context,
            delegate: TweetSearchDelegate(
              initialTab: 1
            ),
            query: '#${hashtag.text}'
        );
      });
    });

    entities = _populateEntities(entities: entities, source: tweet.entities?.userMentions, getNewEntity: (UserMention mention) {
      return TweetUserMention(mention, () {
        Navigator.pushNamed(context, ROUTE_PROFILE, arguments: mention.screenName!);
      });
    });

    entities = _populateEntities(entities: entities, source: tweet.entities?.urls, getNewEntity: (Url url) {
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

  Future<SelectableText> _getTweetContentWidget() async {
    Runes tweetText = Runes(tweet.fullText ?? tweet.text!);

    // If we're not given a text display range, we just display the entire text
    List<int> displayTextRange = tweet.displayTextRange ?? [0, tweetText.length];

    Iterable<int> runes = tweetText.getRange(displayTextRange[0], displayTextRange[1]);

    List<TweetEntity> entities = _getEntities();

    List<InlineSpan> parts = [];
    int index = 0;

    TranslationAPI? translationAPI;

    if(this.translate == true) {
      translationAPI = TranslationAPI();

      var res = await translationAPI.getSupportedLanguages();

      if(res.code != 200) {
        await Fluttertoast.showToast(msg: "Error: Failed to get a list of supported languages to translate", toastLength: Toast.LENGTH_LONG);
        this.translate = false;
      }
      else {
        if(findInJSONArray(res.body, "code", getShortSystemLocale()) == false) {
          this.translate = false;
          await Fluttertoast.showToast(msg: "Error: System language is not supported for translation", toastLength: Toast.LENGTH_LONG);
        }
      }
    }

    await Future.forEach(entities, (TweetEntity part) async {
      // Generate new indices for the entity start and end, by subtracting the displayTextRange's start index, as we ignore text up until that point
      int start = part.getEntityStart() - displayTextRange[0];
      int end = part.getEntityEnd() - displayTextRange[0];

      // Only add entities that are after the displayTextRange's start index
      if(start < 0) {
        return;
      }

      // First, add any text between the last entity's end and the start of this one
      await _addText(parts, runes, translationAPI, index, start);

      // Then add the actual entity
      parts.add(part.getContent());

      // Then set our index in the tweet text as the end of our entity
      index = end;
    });

    await _addText(parts, runes, translationAPI, index);

    return SelectableText.rich(
      TextSpan(
        children: parts
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTweetContentWidget(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2)
            )
          );
        }

        SelectableText widget = snapshot.data as SelectableText;

        return widget;
      }
    );
  }
}