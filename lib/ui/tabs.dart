import 'package:flutter/material.dart';

class ColouredTabBar extends Container implements PreferredSizeWidget {
  final Color color;
  final TabBar child;

  ColouredTabBar({required this.color, required this.child});

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: child,
  );
}