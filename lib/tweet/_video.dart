import 'package:catcher/catcher.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/center_play_button.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fritter/utils/downloads.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';
import 'package:fritter/generated/l10n.dart';

class TweetVideo extends StatefulWidget {
  final String username;
  final bool loop;
  final Media media;

  const TweetVideo({Key? key, required this.username, required this.loop, required this.media}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo> {
  bool _showVideo = false;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
  }

  void _loadVideo() {
    var variants = widget.media.videoInfo?.variants ?? [];
    var url = variants[0].url!;
    _videoController = VideoPlayerController.network(url);

    double aspectRatio = widget.media.videoInfo?.aspectRatio == null
        ? _videoController!.value.aspectRatio
        : widget.media.videoInfo!.aspectRatio![0] / widget.media.videoInfo!.aspectRatio![1];

    _chewieController = ChewieController(
      aspectRatio: aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      allowMuting: true,
      allowedScreenSleep: false,
      additionalOptions: (context) => [
        OptionItem(
          onTap: () async {
            // Find the MP4 video with the highest bitrate
            var video = variants
                .where((e) => e.bitrate != null)
                .where((e) => e.url != null)
                .where((e) => e.contentType == 'video/mp4')
                .sorted((a, b) => a.bitrate!.compareTo(b.bitrate!))
                .firstWhereOrNull((element) => element.url != null);

            if (video == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(L10n.current.download_media_no_url),
              ));
              return;
            }

            var videoUri = Uri.parse(video.url!);
            var fileName = '${widget.username}-${path.basename(videoUri.path)}';

            await downloadUriToPickedFile(
              context,
              videoUri,
              fileName,
              onError: (response) {
                Catcher.reportCheckedError('Unable to save the media. The response was ${response.body}', null);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    L10n.of(context)
                        .unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode(response.statusCode),
                  ),
                ));
              },
              onStart: () {
                Navigator.pop(context);
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
          iconData: Icons.download_sharp,
          title: L10n.of(context).download,
        )
      ],
      looping: widget.loop,
      videoPlayerController: _videoController!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.white,
                size: 42,
              ),
              Text(errorMessage)
            ],
          ),
        );
      },
    );
  }

  void onTapPlay() {
    _loadVideo();

    setState(() {
      _showVideo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: This is a bit flickery, but will do for now
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: _showVideo
        ? Chewie(controller: _chewieController!)
        : GestureDetector(
            onTap: onTapPlay,
            child: Stack(children: [
              ExtendedImage.network(widget.media.mediaUrlHttps!),
              Center(
                child: CenterPlayButton(
                  backgroundColor: Colors.black54,
                  iconColor: Colors.white,
                  isFinished: false,
                  isPlaying: false,
                  show: true,
                  onPressed: onTapPlay,
                ),
              )
            ]),
          )
        );
  }

  @override
  void dispose() {
    // TODO: These now seem to get called when the video player goes fullscreen. They shouldn't though
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}