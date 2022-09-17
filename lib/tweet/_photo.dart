import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

List<double> _doubleTapScales = <double>[1.0, 4.0];

class TweetPhoto extends StatefulWidget {
  final String uri;
  final BoxFit fit;
  final String size;
  final bool pullToClose;
  final bool inPageView;

  const TweetPhoto({Key? key, required this.uri, this.fit = BoxFit.fitWidth, required this.size, required this.pullToClose, required this.inPageView}) : super(key: key);

  @override
  State<TweetPhoto> createState() => _TweetPhotoState();
}

class _TweetPhotoState extends State<TweetPhoto> with SingleTickerProviderStateMixin {
  Animation<double>? _doubleClickAnimation;
  late void Function() _doubleClickAnimationListener;
  late final AnimationController _doubleClickAnimationController =
      AnimationController(duration: const Duration(milliseconds: 150), vsync: this);

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.vertical,
      child: ExtendedImage.network(
        '${widget.uri}:${widget.size}',
        cache: true,
        width: 5000,
        height: 5000,
        fit: widget.fit,
        mode: ExtendedImageMode.gesture,
        enableSlideOutPage: widget.pullToClose,
        initGestureConfigHandler: (state) {
          return GestureConfig(
            inPageView: widget.inPageView,
            minScale: 0.9,
            animationMinScale: 0.7,
            maxScale: 4.0,
            animationMaxScale: 4.0,
            speed: 1.0,
            inertialSpeed: 100.0,
            initialScale: 1.0,
            initialAlignment: InitialAlignment.center,
          );
        },
        onDoubleTap: (ExtendedImageGestureState state) {
          final Offset? pointerDownPosition = state.pointerDownPosition;
          final double? begin = state.gestureDetails!.totalScale;
          double end;

          // Remove and stop any old animation
          _doubleClickAnimation?.removeListener(_doubleClickAnimationListener);
          _doubleClickAnimationController.stop();
          _doubleClickAnimationController.reset();

          if (begin == _doubleTapScales[0]) {
            end = _doubleTapScales[1];
          } else {
            end = _doubleTapScales[0];
          }

          _doubleClickAnimationListener = () {
            state.handleDoubleTap(scale: _doubleClickAnimation!.value, doubleTapPosition: pointerDownPosition);
          };

          _doubleClickAnimation = _doubleClickAnimationController.drive(Tween<double>(begin: begin, end: end));
          _doubleClickAnimation!.addListener(_doubleClickAnimationListener);
          _doubleClickAnimationController.forward();
        },
      ),
    );
  }
}
