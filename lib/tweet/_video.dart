import 'package:catcher/catcher.dart';
import 'package:chewie/chewie.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:fritter/tweet/_video_controls.dart';
import 'package:fritter/utils/downloads.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';
import 'package:fritter/generated/l10n.dart';

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
        ? _videoController.value.aspectRatio
        : widget.media.videoInfo!.aspectRatio![0] / widget.media.videoInfo!.aspectRatio![1];

    _videoController = VideoPlayerController.network(url);
    _chewieController = ChewieController(
      aspectRatio: aspectRatio,
      autoInitialize: true,
      allowMuting: true,
      customControls: const MaterialDesktopControls(),
      allowedScreenSleep: false,
      additionalOptions: (context) => [
        OptionItem(
          onTap: () async {
            var fileName = path.basename(url);

            await downloadUriToPickedFile(
              url,
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
      videoPlayerController: _videoController,
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
