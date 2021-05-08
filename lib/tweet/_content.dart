import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home/_search.dart';
import 'package:fritter/profile/profile.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:url_launcher/url_launcher.dart';

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

class TweetContent extends StatelessWidget {
  final Tweet tweet;

  TweetContent({ required this.tweet });

  @override
  Widget build(BuildContext context) {
    List<TweetEntity> entities = [];

    var hashtags = tweet.entities?.hashtags ?? [];
    for (var hashtag in hashtags) {
      entities.add(TweetHashtag(hashtag, () async {
        await showSearch(
            context: context,
            delegate: TweetSearchDelegate(
              initialTab: 1
            ),
            query: Uri.decodeQueryComponent('#${hashtag.text}')
        );
      }));
    }

    var mentions = tweet.entities?.userMentions ?? [];
    for (var mention in mentions) {
      entities.add(TweetUserMention(mention, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(id: mention.idStr, username: mention.screenName!)));
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

    var tweetText = Runes(tweet.fullText ?? tweet.text!);

    // If we're not given a text display range, we just display the entire text
    var displayTextRange = tweet.displayTextRange;
    if (displayTextRange == null) {
      displayTextRange = [0, tweetText.length];
    }

    List<InlineSpan> parts = [];
    var index = 0;

    // Don't use the starting text range, as it might be a mention and I haven't figured out how to not mangle that text
    var runes = tweetText.getRange(0, displayTextRange[1]);

    entities.sort((a, b) => a.getEntityStart().compareTo(b.getEntityStart()));

    var htmlUnescape = HtmlUnescape();

    var addText = (int start, [int? end]) {
      var string = runes.getRange(start, end).map((e) => String.fromCharCode(e)).join('');
      if (string.isEmpty) {
        return;
      }

      parts.add(TextSpan(text: htmlUnescape.convert(string), style: Theme.of(context).textTheme.bodyText2));
    };

    entities.forEach((part) {
      // First, add any text between the last entity's end and the start of this one
      addText(index, part.getEntityStart());

      // Then add the actual entity
      parts.add(part.getContent());

      // Then set our index in the tweet text as the end of our entity
      index = part.getEntityEnd();
    });

    // Finally, add any remaining tweet text
    addText(index);

    return SelectableText.rich(
      TextSpan(
        children: parts
      ),
    );
  }
}