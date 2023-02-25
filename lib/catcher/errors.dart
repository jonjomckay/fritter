import 'package:fritter/catcher/exceptions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Catcher {
  static void reportSyntheticException(SyntheticException error) {
    Sentry.captureException(error);
  }

  static void reportException(Object? e, [Object? stackTrace]) {
    Sentry.captureException(e, stackTrace: stackTrace);
  }
}