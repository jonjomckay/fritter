import 'package:flutter/material.dart';

/// The default PageView scroll physics are very sensitive, and easily swipe pages when you mean to scroll up and down
/// instead. This dampens the physics, by making the widget "heavy" (mass), so it's harder to swipe.
class LessSensitiveScrollPhysics extends ScrollPhysics {
  const LessSensitiveScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  LessSensitiveScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return LessSensitiveScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 50,
    stiffness: 100,
    damping: 1,
  );
}