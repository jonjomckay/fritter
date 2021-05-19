import 'dart:developer';
import 'dart:math' as math;

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/tweet/_photo.dart';
import 'package:fritter/tweet/_video.dart';
import 'package:fritter/utils/downloads.dart';
import 'package:path/path.dart' as path;
import 'package:pref/pref.dart';

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

    var mediaSize = PrefService.of(context, listen: false)
        .get(OPTION_MEDIA_SIZE);

    if (mediaSize == 'disabled') {
      // If the image is cached already, show the media
      cachedImageExists(widget.media.mediaUrlHttps!)
          .then((value) => setState(() {
        _showMedia = value;
      }));
    } else {
      setState(() {
        _showMedia = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context, listen: false);
    var size = prefs.get(OPTION_MEDIA_SIZE);
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
        media = Text('Unknown');
      }
    } else {
      media = GestureDetector(
        child: Container(
          color: Colors.black26,
          child: Center(
            child: Text('Tap to show media'),
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
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            child: Text('${widget.index} / ${widget.total}'),
          ),
        )
      ],
    );
  }
}

class TweetMedia extends StatefulWidget {
  final List<Media> media;

  const TweetMedia({Key? key, required this.media}) : super(key: key);

  @override
  _TweetMediaState createState() => _TweetMediaState();
}

class _TweetMediaState extends State<TweetMedia> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var largestAspectRatio = widget.media
        .map((e) => ((e.sizes!.large!.w) ?? 1) / ((e.sizes!.large!.h) ?? 1))
        .reduce(math.max);

    return Container(
      margin: EdgeInsets.only(top: 8, left: 16, right: 16),
      child: AspectRatio(
        aspectRatio: largestAspectRatio,
        child: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.media.length,
          itemBuilder: (context, index) {
            var item = widget.media[index];

            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TweetMediaView(initialIndex: index, media: widget.media))),
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

  const TweetMediaView({Key? key, required this.initialIndex, required this.media}) : super(key: key);

  @override
  _TweetMediaViewState createState() => _TweetMediaViewState();
}

class _TweetMediaViewState extends State<TweetMediaView> {
  late Media _media;

  @override
  void initState() {
    super.initState();

    this._media = widget.media[widget.initialIndex];
  }

  @override
  Widget build(BuildContext context) {
    var prefs = PrefService.of(context, listen: false);
    var size = prefs.get(OPTION_MEDIA_SIZE);
    if (size == 'disabled') {
      size = 'medium';
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              var fileName = path.basename(_media.mediaUrlHttps!);
              var uri = '${_media.mediaUrlHttps}:orig';

              await downloadUriToPickedFile(uri, fileName,
                onError: (response) {
                  log('Unable to save the media. The response was ${response.body}');

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Unable to save the media. Twitter returned a status of ${response.statusCode}'),
                  ));
                },
                onStart: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Downloading media...'),
                  ));
                },
                onSuccess: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Successfully saved the media!'),
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
          var item = this.widget.media[index];

          Widget media;
          if (item.type == 'animated_gif') {
            media = TweetVideo(media: item, loop: true);
          } else if (item.type == 'video') {
            media = TweetVideo(media: item, loop: false);
          } else if (item.type == 'photo') {
            media = TweetPhoto(inPageView: true, size: size, uri: item.mediaUrlHttps!);
          } else {
            media = Text('Unknown');
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