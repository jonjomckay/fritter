import 'dart:math' as math;

import 'package:catcher/catcher.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/tweet/_photo.dart';
import 'package:fritter/tweet/_video.dart';
import 'package:fritter/utils/downloads.dart';
import 'package:path/path.dart' as path;
import 'package:pref/pref.dart';
import 'package:fritter/generated/l10n.dart';

class TweetMediaItem extends StatefulWidget {
  final int index;
  final int total;
  final Media media;

  const TweetMediaItem({Key? key, required this.index, required this.total, required this.media}) : super(key: key);

  @override
  _TweetMediaItemState createState() => _TweetMediaItemState();
}

class _TweetMediaItemState extends State<TweetMediaItem> {
  bool _showMedia = false;

  @override
  void initState() {
    super.initState();

    var mediaSize = PrefService.of(context, listen: false).get(optionMediaSize);

    if (mediaSize == 'disabled') {
      // If the image is cached already, show the media
      cachedImageExists(widget.media.mediaUrlHttps!).then((value) => setState(() {
            _showMedia = value;
          }));
    } else {
      setState(() {
        _showMedia = true;
      });
    }
  }

  String getMediaType(String? type) {
    switch (type) {
      case 'animated_gif':
        return 'GIF';
      case 'photo':
        return 'photo';
      case 'video':
        return 'video';
      default:
        return 'media';
    }
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context, listen: false);
    var size = prefs.get(optionMediaSize);
    if (size == 'disabled') {
      size = 'medium';
    }

    Widget media;

    var item = widget.media;

    if (_showMedia) {
      if (item.type == 'animated_gif') {
        media = TweetVideo(media: item, loop: true);
      } else if (item.type == 'video') {
        media = TweetVideo(media: item, loop: false);
      } else if (item.type == 'photo') {
        media = TweetPhoto(size: size, uri: item.mediaUrlHttps!);
      } else {
        media = Text(L10n.of(context).unknown);
      }
    } else {
      media = GestureDetector(
        child: Container(
          color: Colors.black26,
          child: Center(
            child: Text(
              L10n.of(context).tap_to_show_getMediaType_item_type(getMediaType(item.type)),
            ),
          ),
        ),
        onTap: () => setState(() {
          _showMedia = true;
        }),
      );
    }

    // If there's only one item in this media collection, don't show the page counter
    if (widget.total == 1) {
      return media;
    }

    return Stack(
      children: [
        Center(child: media),
        Positioned(
          right: 0,
          child: Container(
            alignment: Alignment.topRight,
            color: Colors.black38,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Text('${widget.index} / ${widget.total}'),
          ),
        )
      ],
    );
  }
}

class TweetMedia extends StatefulWidget {
  final List<Media> media;
  final String username;

  const TweetMedia({Key? key, required this.media, required this.username}) : super(key: key);

  @override
  _TweetMediaState createState() => _TweetMediaState();
}

class _TweetMediaState extends State<TweetMedia> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var largestAspectRatio =
        widget.media.map((e) => ((e.sizes!.large!.w) ?? 1) / ((e.sizes!.large!.h) ?? 1)).reduce(math.max);

    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: AspectRatio(
        aspectRatio: largestAspectRatio,
        child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.media.length,
          itemBuilder: (context, index) {
            var item = widget.media[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TweetMediaView(initialIndex: index, media: widget.media, username: widget.username))),
              child: TweetMediaItem(media: item, index: index + 1, total: widget.media.length),
            );
          },
        ),
      ),
    );
  }
}

class TweetMediaView extends StatefulWidget {
  final int initialIndex;
  final List<Media> media;
  final String username;

  const TweetMediaView({Key? key, required this.initialIndex, required this.media, required this.username})
      : super(key: key);

  @override
  _TweetMediaViewState createState() => _TweetMediaViewState();
}

class _TweetMediaViewState extends State<TweetMediaView> {
  late Media _media;
  late String _username;

  @override
  void initState() {
    super.initState();

    _media = widget.media[widget.initialIndex];
    _username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context, listen: false);
    var size = prefs.get(optionMediaSize);
    if (size == 'disabled') {
      size = 'medium';
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () async {
              var url = path.basename(_media.mediaUrlHttps!);
              var fileName = '$_username-$url';
              var uri = '${_media.mediaUrlHttps}:orig';

              await downloadUriToPickedFile(
                uri,
                fileName,
                onError: (response) {
                  Catcher.reportCheckedError('Unable to save the media. The response was ${response.body}', null);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      L10n.of(context).unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode(
                          response.statusCode),
                    ),
                  ));
                },
                onStart: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(L10n.of(context).downloading_media),
                  ));
                },
                onSuccess: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(L10n.of(context).successfully_saved_the_media),
                  ));
                },
              );
            },
          )
        ],
      ),
      body: ExtendedImageGesturePageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.media.length,
        itemBuilder: (BuildContext context, int index) {
          var item = widget.media[index];

          Widget media;
          if (item.type == 'animated_gif') {
            media = TweetVideo(media: item, loop: true);
          } else if (item.type == 'video') {
            media = TweetVideo(media: item, loop: false);
          } else if (item.type == 'photo') {
            media = TweetPhoto(inPageView: true, size: size, uri: item.mediaUrlHttps!);
          } else {
            media = Text(L10n.of(context).unknown);
          }

          return media;
        },
        controller: PageController(
          initialPage: widget.initialIndex,
        ),
        onPageChanged: (index) => setState(() {
          _media = widget.media[index];
        }),
      ),
    );
  }
}
