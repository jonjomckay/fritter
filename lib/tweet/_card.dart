import 'dart:convert';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/constants.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class TweetCard extends StatelessWidget {
  static final log = Logger('TweetCard');

  final TweetWithCard tweet;
  final Map<String, dynamic>? card;

  const TweetCard({Key? key, required this.tweet, required this.card}) : super(key: key);

  _createBaseCard(Widget child) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.blue,
          child: child,
        )
    );
  }

  _createCard(String? url, Widget child) {
    return GestureDetector(
      child: _createBaseCard(child),
      onTap: () => url == null ? null : launch(url),
    );
  }

  _createImage(String size, Map<String, dynamic>? image, BoxFit fit, { double? aspectRatio }) {
    if (image == null) {
      return Container();
    }

    Widget child;

    if (size == 'disabled') {
      child = Container();
    } else {
      child = ExtendedImage.network(
        image['url'],
        cache: true,
        fit: fit,
      );
    }

    return AspectRatio(
      aspectRatio: aspectRatio ?? image['width'] / image['height'],
      child: child,
    );
  }

  _createListTile(BuildContext context, String title, String? description, String? uri) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          if (description != null)
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                    fontSize: 12
                ),
              ),
            ),
          if (uri != null)
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.link, size: 12, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    uri,
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

  _createVoteBar(BuildContext context, Map<String, dynamic> card, double total, int choiceIndex) {
    var choiceCount = double.parse(card['binding_values']['choice${choiceIndex}_count']['string_value']);
    var choicePercent = (100 / total) * choiceCount;

    var theme = Theme.of(context);
    var textColor = theme.brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(
          height: 24,
          child: LinearProgressIndicator(
            value: choicePercent / 100,
            color: theme.brightness == Brightness.light
              ? Colors.blue.withOpacity(0.3)
              : Colors.blue.withOpacity(0.7)
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${choicePercent.toStringAsFixed(1)}% ', style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: card['binding_values']['choice${choiceIndex}_label']['string_value'], style: TextStyle(
                      color: textColor,
                    ))
                  ]
              ),
            )
        ),
      ]),
    );
  }

  _createUnifiedCard(BuildContext context, Map<String, dynamic> card, String imageKey, String imageSize) {
    var unifiedCard = jsonDecode(card['binding_values']['unified_card']['string_value']) as Map<String, dynamic>;

    switch (unifiedCard['type']) {
      case 'image_website':
        var image = unifiedCard['media_entities'][unifiedCard['component_objects']['media_1']['data']['id']];
        var uri = unifiedCard['destination_objects']['browser_1']['data']['url_data']['url'];

        return _createCard(uri, Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageSize != 'disabled')
              _createImage(imageSize, {
                'url': image['media_url_https'],
                'width': image['original_info']['width'],
                'height': image['original_info']['height'],
              }, BoxFit.contain),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: _createListTile(
                  context,
                  unifiedCard['component_objects']['details_1']['data']['title']['content'],
                  unifiedCard['component_objects']['details_1']['data']['subtitle']['content'],
                  null
              ),
            ),
          ],
        ));
      default:
        log.warning('Unsupported unified card type ${unifiedCard['type']} encountered');
        return Container();
    }
  }

  _createVoteCard(BuildContext context, Map<String, dynamic> card, int numberOfChoices) {
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
            ...List.generate(numberOfChoices, (index) => _createVoteBar(context, card, total, ++index)),
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

  String? _findCardUrl(Map<String, dynamic> card) {
    var link = card['url'];
    var urls = tweet.entities?.urls ?? [];

    // Match up the card's URL with the link in the tweet entities, otherwise just use the card's URL
    var url = urls.firstWhere((element) => element.url == link, orElse: () => Url.fromJson({
      'expanded_url': link
    }));

    return url.expandedUrl;
  }

  @override
  Widget build(BuildContext context) {
    var card = this.card;
    if (card == null) {
      return Container();
    }

    var imageKey = '';
    var imageSize = PrefService.of(context, listen: false).get(OPTION_MEDIA_SIZE);
    if (imageSize == 'thumb') {
      imageKey = '_small';
    } else if (imageSize == 'medium') {
      imageKey = '_large';
    } else if (imageSize == 'large') {
      imageKey = '_x_large';
    }

    switch (card['name']) {
      case 'summary':
        var image = card['binding_values']['thumbnail_image$imageKey']?['image_value'];

        return _createCard(_findCardUrl(card), Row(
          children: [
            if (imageSize != 'disabled')
              Expanded(flex: 1, child: _createImage(imageSize, image, BoxFit.contain)),
            Expanded(flex: 4, child: _createListTile(
              context,
              card['binding_values']['title']['string_value'],
              card['binding_values']?['description']?['string_value'],
              card['binding_values']?['vanity_url']?['string_value']
            ))
          ],
        ));
      case 'summary_large_image':
        var image = card['binding_values']['thumbnail_image$imageKey']?['image_value'];

        return _createCard(_findCardUrl(card), Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageSize != 'disabled')
              _createImage(imageSize, image, BoxFit.contain),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: _createListTile(
                context,
                card['binding_values']['title']['string_value'],
                card['binding_values']?['description']?['string_value'],
                card['binding_values']?['vanity_url']?['string_value']
              ),
            ),
          ],
        ));
      case 'player':
        var image = card['binding_values']['player_image$imageKey']?['image_value'];

        return _createCard(_findCardUrl(card), Row(
          children: [
            Expanded(flex: 1, child: _createImage(imageSize, image, BoxFit.cover, aspectRatio: 1)),
            Expanded(flex: 4, child: _createListTile(
              context,
              card['binding_values']['title']['string_value'],
              card['binding_values']?['description']?['string_value'],
              card['binding_values']?['vanity_url']?['string_value']
            ))
          ],
        ));
      case 'poll2choice_text_only':
        return _createVoteCard(context, card, 2);
      case 'poll3choice_text_only':
        return _createVoteCard(context, card, 3);
      case 'poll4choice_text_only':
        return _createVoteCard(context, card, 4);
      case 'unified_card':
        try {
          return _createUnifiedCard(context, card, imageKey, imageSize);
        } catch (e, stackTrace) {
          log.severe('Unable to render the unified card', e, stackTrace);
          return Container();
        }
      default:
        log.warning('Unknown card type ${card['name']} was encountered');
        return Container();
    }
  }
}
