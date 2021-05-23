import 'dart:developer';

import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderWrapper<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget Function() onEmpty;
  final Widget Function(Object? error, StackTrace? stackTrace) onError;
  final Widget Function(T data) onReady;

  const FutureBuilderWrapper({Key? key, required this.future, required this.onEmpty, required this.onError, required this.onReady}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        var state = snapshot.connectionState;

        switch (state) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              // TODO: Should this be here? It stacks on things like lists...
              Catcher.reportCheckedError(snapshot.error, snapshot.stackTrace);

              return onError(snapshot.error, snapshot.stackTrace);
            }

            var data = snapshot.data;
            if (data == null) {
              return Center(child: onEmpty());
            }

            return onReady(data);
          default:
            return Center(child: Text('The connection state $state is not supported'));
        }
      },
    );
  }
}
