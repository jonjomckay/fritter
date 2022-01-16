import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TweetPhoto extends StatelessWidget {
  final String uri;
  final BoxFit fit;
  final String size;
  final bool inPageView;

  const TweetPhoto(
      {Key? key, required this.uri, this.fit = BoxFit.fitWidth, required this.size, this.inPageView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      '$uri:$size',
      cache: true,
      width: 5000,
      height: 5000,
      fit: fit,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 1.0,
          animationMinScale: 0.7,
          maxScale: 3.0,
          animationMaxScale: 3.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: inPageView,
          initialAlignment: InitialAlignment.center,
        );
      },
    );
  }
}
