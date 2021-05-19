import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/tweet/_video_controls.dart';
import 'package:fritter/utils/downloads.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

class TweetVideo extends StatefulWidget {
  final bool loop;
  final Media media;

  const TweetVideo({Key? key, required this.loop, required this.media}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    var url = widget.media.videoInfo!.variants![0].url!;

    double aspectRatio = widget.media.videoInfo?.aspectRatio == null
        ?  _videoController.value.aspectRatio
        : widget.media.videoInfo!.aspectRatio![0] / widget.media.videoInfo!.aspectRatio![1];

    _videoController = VideoPlayerController.network(url);
    _chewieController = ChewieController(
      aspectRatio: aspectRatio,
      autoInitialize: true,
      customControls: VideoControls(
        customControls: [
          GestureDetector(
            onTap: () async {
              var fileName = path.basename(url);

              await downloadUriToPickedFile(url, fileName,
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
            child: ClipRect(
              child: Container(
                height: 48,
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Icon(Icons.download_sharp),
              ),
            ),
          )
        ],
      ),
      looping: widget.loop,
      videoPlayerController: _videoController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}