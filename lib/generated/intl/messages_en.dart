// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(fileName) => "Data exported to ${fileName}";

  static String m1(fullPath) => "Data exported to ${fullPath}";

  static String m2(e) => "Unable to send the ping. ${e}";

  static String m3(statusCode) =>
      "Unable to send the ping. The status code was ${statusCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_to_group": MessageLookupByLibrary.simpleMessage("Add to group"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "An error was reported to Sentry. Thank you!"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Couldn\'t find any tweets by this user!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Couldn\'t find any tweets from the last 7 days!"),
        "data_exported_to_fileName": m0,
        "data_exported_to_fullPath": m1,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("Data imported successfully"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Don\'t send"),
        "export": MessageLookupByLibrary.simpleMessage("Export"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Export settings?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Export subscription group members?"),
        "export_subscription_groups":
            MessageLookupByLibrary.simpleMessage("Export subscription groups?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Export subscriptions?"),
        "export_tweets": MessageLookupByLibrary.simpleMessage("Export tweets?"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "followers": MessageLookupByLibrary.simpleMessage("Followers"),
        "following": MessageLookupByLibrary.simpleMessage("Following"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Here is the data that will be sent. It will only be used to determine which devices and languages to support in Fritter in the future."),
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Include replies"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Include retweets"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "It looks like you\'ve already said hello from this version of Fritter!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "It looks like you\'ve already sent a ping recently 🤔"),
        "media": MessageLookupByLibrary.simpleMessage("Media"),
        "never_send": MessageLookupByLibrary.simpleMessage("Never send"),
        "no_results": MessageLookupByLibrary.simpleMessage("No results"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Note: Due to a Twitter limitation, not all tweets may be included"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Reporting an error"),
        "saved": MessageLookupByLibrary.simpleMessage("Saved"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Say Hello 👋"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "send_always": MessageLookupByLibrary.simpleMessage("Send always"),
        "send_once": MessageLookupByLibrary.simpleMessage("Send once"),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Something just went wrong in Fritter, and an error report has been generated. The report can be sent to the Fritter developers to help fix the problem."),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Subscriptions"),
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Thanks for helping Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Thanks for reporting. We\'ll try and fix it in no time!"),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "This group contains no subscriptions!"),
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "This user does not follow anyone!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "This user does not have anyone following them!"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Timed out trying to send the ping 😢"),
        "trending": MessageLookupByLibrary.simpleMessage("Trending"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweets"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweets & Replies"),
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "Unable to check if this is a legacy Android device."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage(
                "Unable to find the app\'s package info"),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Unable to find your saved tweets."),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load subscription groups"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("Unable to load the group"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the group settings"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the list of follows"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the next page of follows"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the next page of replies"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the next page of tweets"),
        "unable_to_load_the_profile":
            MessageLookupByLibrary.simpleMessage("Unable to load the profile"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the search results."),
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Unable to load the tweet"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("Unable to load the tweets"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the tweets for the feed"),
        "unable_to_send_the_ping_e_to_string": m2,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m3,
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Unsubscribe"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Would you like to enable automatic error reporting?"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "You haven\'t saved any tweets yet!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Your device is running a version of Android older than KitKat (4.4), so the export can only be saved to:"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Your report will be sent to Fritter\'s Sentry project, and privacy details can be found at:")
      };
}
