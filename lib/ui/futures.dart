import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/generated/l10n.dart';

class FutureBuilderWrapper<T> extends StatelessWidget {
  final Future<T>? future;
  final FritterErrorWidget Function(Object? error, StackTrace? stackTrace) onError;
  final Widget Function(T data) onReady;

  const FutureBuilderWrapper({Key? key, required this.future, required this.onError, required this.onReady})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        var state = snapshot.connectionState;

        if (snapshot.hasError) {
          Catcher.reportCheckedError(snapshot.error, snapshot.stackTrace);
          return Center(child: onError(snapshot.error, snapshot.stackTrace));
        }

        switch (state) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: Text(
                  L10n.of(context).no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible,
                ),
              );
            }

            return onReady(data);
          default:
            return Center(
              child: Text(
                L10n.of(context).the_connection_state_state_is_not_supported(state),
              ),
            );
        }
      },
    );
  }
}
