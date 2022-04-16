import 'package:flutter/material.dart';

class LoadingStack extends StatelessWidget {
  final bool loading;
  final Widget child;

  const LoadingStack({Key? key, required this.loading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        AnimatedOpacity(
          opacity: loading ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 500),
          child: child,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(64),
            child: AnimatedOpacity(
              opacity: loading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
