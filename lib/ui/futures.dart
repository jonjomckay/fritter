import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderWrapper<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget Function(Object? error, StackTrace? stackTrace) onError;
  final Widget Function(T? data) onReady;

  const FutureBuilderWrapper({Key? key, required this.future, required this.onError, required this.onReady}) : super(key: key);

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
              log('An error occurred', error: snapshot.error, stackTrace: snapshot.stackTrace);

              return onError(snapshot.error, snapshot.stackTrace);
            }

            return onReady(snapshot.data);
          default:
            return Center(child: Text('The connection state $state is not supported'));
        }
      },
    );
  }
}
