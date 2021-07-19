import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/home/_search.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

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

  bool hasRun = false;

  TweetContentState({ required this.tweet }): super();

  _addText(List<InlineSpan> parts,Iterable<int> runes, int start, [int? end]) async {
    var string = runes.getRange(start, end).map((e) => String.fromCharCode(e)).join('');
    if (string.isEmpty) {
      return;
    }

    var htmlUnescape = HtmlUnescape();

    String text = htmlUnescape.convert(string);

    debugPrint("Translate: " + this.translate.toString());

    if(this.translate) {
      Response res = await post(new Uri(
        scheme: "https",
        host: "libretranslate.de",
        path: "translate",
        queryParameters: {
          'q': text,
          'source': tweet.lang,
          'target': "es" //Platform.localeName.split('_')[0]
        }
      ));

      if(res.statusCode != 200) {
        throw("Failed to translate tweet!");
      }

      text = jsonDecode(res.body)["translatedText"];
    }
    
    parts.add(TextSpan(text: text, style: Theme.of(context).textTheme.bodyText2));
  }

  _init(Iterable<int> runes, List<int> displayTextRange) async { 
    List<TweetEntity> entities = [];

    var hashtags = tweet.entities?.hashtags ?? [];
    for (var hashtag in hashtags) {
      entities.add(TweetHashtag(hashtag, () async {
        await showSearch(
            context: context,
            delegate: TweetSearchDelegate(
              initialTab: 1
            ),
            query: '#${hashtag.text}'
        );
      }));
    }

    var mentions = tweet.entities?.userMentions ?? [];
    for (var mention in mentions) {
      entities.add(TweetUserMention(mention, () {
        Navigator.pushNamed(context, ROUTE_PROFILE, arguments: mention.screenName!);
      }));
    }

    var urls = tweet.entities?.urls ?? [];
    for (var url in urls) {
      entities.add(TweetUrl(url, () async {
        var uri = url.expandedUrl;
        if (uri == null) {
          return;
        }

        await launch(uri);
      }));
    }

    List<InlineSpan> parts = [];
    int index = 0;

    entities.sort((a, b) => a.getEntityStart().compareTo(b.getEntityStart()));

    await Future.forEach(entities, (TweetEntity part) async {
      // Generate new indices for the entity start and end, by subtracting the displayTextRange's start index, as we ignore text up until that point
      int start = part.getEntityStart() - displayTextRange[0];
      int end = part.getEntityEnd() - displayTextRange[0];

      // Only add entities that are after the displayTextRange's start index
      if (start >= 0) {
        // First, add any text between the last entity's end and the start of this one
        await _addText(parts, runes, index, start);

        // Then add the actual entity
        parts.add(part.getContent());

        // Then set our index in the tweet text as the end of our entity
        index = end;
      }
    });

    await _addText(parts, runes, index);

    debugPrint("parts: " + parts.toString() + "\nindex: " + index.toString());

    return parts;
  }

  setTranslate(bool translate) {
    setState(() {
      this.translate = translate;
    });
  }

  test() async {
    var tweetText = Runes(tweet.fullText ?? tweet.text!);

    // If we're not given a text display range, we just display the entire text
    var displayTextRange = tweet.displayTextRange;
    if (displayTextRange == null) {
      displayTextRange = [0, tweetText.length];
    }

    var runes = tweetText.getRange(displayTextRange[0], displayTextRange[1]);

    List<InlineSpan> parts = await _init(runes, displayTextRange);

    return SelectableText.rich(
      TextSpan(
        children: parts
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: test(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done) {
          return Container();
        }

        Widget widget = snapshot.data as Widget;

        return widget;
      }
    );
  }
}