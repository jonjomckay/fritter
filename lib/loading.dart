import 'package:flutter/material.dart';

class LoadingStack extends StatelessWidget {
  final bool loading;
  final Widget child;

  const LoadingStack({Key key, this.loading, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        AnimatedOpacity(
          opacity: loading ? 0.0 : 1.0,
          duration: Duration(milliseconds: 500),
          child: child,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(64),
            child: AnimatedOpacity(
              opacity: loading ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

}