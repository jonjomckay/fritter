import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class TweetCard extends StatelessWidget {
  final TweetWithCard tweet;
  final Map<String, dynamic>? card;

  const TweetCard({Key? key, required this.tweet, required this.card}) : super(key: key);

  _createCard(Map<String, dynamic> card, Widget child) {
    var link = card['url'];
    var urls = tweet.entities?.urls ?? [];

    // Match up the card's URL with the link in the tweet entities, otherwise just use the card's URL
    var url = urls.firstWhere((element) => element.url == link, orElse: () => Url.fromJson({
      'expanded_url': link
    }));

    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.blue,
            child: child,
          )
      ),
      onTap: () => launch(url.expandedUrl!),
    );
  }

  _createImage(Map<String, dynamic>? image, BoxFit fit, { double? aspectRatio }) {
    if (image == null) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: aspectRatio ?? image['width'] / image['height'],
      child: ExtendedImage.network(
        image['url'],
        cache: true,
        fit: fit,
      ),
    );
  }

  _createListTile(BuildContext context, Map<String, dynamic> card) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              card['binding_values']['title']['string_value'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          if (card['binding_values']?['description']?['string_value'] != null)
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                card['binding_values']['description']['string_value'],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                    fontSize: 12
                ),
              ),
            ),
          if (card['binding_values']?['vanity_url']?['string_value'] != null)
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.link, size: 12, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                      card['binding_values']['vanity_url']['string_value'],
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  _createVoteBar(Map<String, dynamic> card, double total, int choiceIndex) {
    var choiceCount = double.parse(card['binding_values']['choice${choiceIndex}_count']['string_value']);
    var choicePercent = (100 / total) * choiceCount;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(
          height: 24,
          child: LinearProgressIndicator(value: choicePercent / 100),
        ),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${choicePercent.toStringAsFixed(1)}% ', style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: card['binding_values']['choice${choiceIndex}_label']['string_value'])
                  ]
              ),
            )
        ),
      ]),
    );
  }

  _createVoteCard(Map<String, dynamic> card, int numberOfChoices) {
    var numberFormat = NumberFormat.decimalPattern();

    var total = List.generate(numberOfChoices, (index) => double.parse(card['binding_values']['choice${++index}_count']['string_value']))
      .reduce((value, element) => value + element);

    String endsAtText;

    var endsAt = DateTime.parse(card['binding_values']['end_datetime_utc']['string_value']);
    if (endsAt.isBefore(DateTime.now())) {
      endsAtText = 'Ended ${timeago.format(endsAt, allowFromNow: true)}';
    } else {
      endsAtText = 'Ends ${timeago.format(endsAt, allowFromNow: true)}';
    }

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ...List.generate(numberOfChoices, (index) => _createVoteBar(card, total, ++index)),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 8),
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: '${numberFormat.format(total)} votes'),
                      TextSpan(text: ' • '),
                      TextSpan(text: endsAtText)
                    ]
                ),
              ),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    var card = this.card;
    if (card == null) {
      return Container();
    }

    switch (card['name']) {
      case 'summary':
        var image = card['binding_values']['thumbnail_image_large']?['image_value'];

        return _createCard(card, Row(
          children: [
            Expanded(flex: 1, child: _createImage(image, BoxFit.contain)),
            Expanded(flex: 4, child: _createListTile(context, card))
          ],
        ));
      case 'summary_large_image':
        var image = card['binding_values']['summary_photo_image']?['image_value'];

        return _createCard(card, Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createImage(image, BoxFit.contain),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: _createListTile(context, card),
            ),
          ],
        ));
      case 'player':
        var image = card['binding_values']['player_image']?['image_value'];

        return _createCard(card, Row(
          children: [
            Expanded(flex: 1, child: _createImage(image, BoxFit.cover, aspectRatio: 1)),
            Expanded(flex: 4, child: _createListTile(context, card))
          ],
        ));
      case 'poll2choice_text_only':
        return _createVoteCard(card, 2);
      case 'poll3choice_text_only':
        return _createVoteCard(card, 3);
      case 'poll4choice_text_only':
        return _createVoteCard(card, 4);
      default:
        log('Unknown card type ${card['name']} was encountered');
        return Container();
    }
  }
}
