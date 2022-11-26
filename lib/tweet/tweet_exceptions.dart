import 'package:fritter/catcher/exceptions.dart';

class TweetMissingDataException with SyntheticException implements Exception {
  final String? id;
  final List<String> missingFields;

  TweetMissingDataException(this.id, this.missingFields);

  @override
  String toString() {
    return 'TweetMissingDataException{id: $id, missingFields: $missingFields}';
  }
}
