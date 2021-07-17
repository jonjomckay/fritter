import 'package:flutter/material.dart';
import 'package:fritter/ui/errors.dart';
import 'package:logging/logging.dart';

class FutureBuilderWrapper<T> extends StatelessWidget {
  final Future<T>? future;
  final FritterErrorWidget Function(Object? error, StackTrace? stackTrace) onError;
  final Widget Function(T data) onReady;

  const FutureBuilderWrapper({Key? key, required this.future, required this.onError, required this.onReady}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        var state = snapshot.connectionState;

        if (snapshot.hasError) {
          Logger.root.severe('Unexpected error', snapshot.error, snapshot.stackTrace);
          return Center(child: onError(snapshot.error, snapshot.stackTrace));
        }

        switch (state) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            var data = snapshot.data;
            if (data == null) {
              return Center(child: Text('No data was returned, which should never happen. Please report a bug, if possible!'));
            }

            return onReady(data);
          default:
            return Center(child: Text('The connection state $state is not supported'));
        }
      },
    );
  }
}
