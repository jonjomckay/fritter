// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a eu locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'eu';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_to_group": MessageLookupByLibrary.simpleMessage("Gehitu taldera"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Ezin izan da erabiltzaile honen txiorik aurkitu!"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Akats baten berri eman"),
        "select": MessageLookupByLibrary.simpleMessage("Hautatu"),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Zerbait gaizki atera da Fritter-en, eta akatsen txostena sortu da. Txostena Fritterren garatzaileei bidali ahal zaie arazoa konpontzen laguntzeko."),
        "subscribe": MessageLookupByLibrary.simpleMessage("Harpidetu"),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Talde honek ez du harpidetzarik!"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Ezin dira harpidetza taldeak kargatu"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Ezin da hurrengo erantzunen orria kargatu"),
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Ezin da txioa kargatu"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Kendu harpidetza"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Akats txostenen berri emate automatikoa gaitu nahi duzu?")
      };
}
