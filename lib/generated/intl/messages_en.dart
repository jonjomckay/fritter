// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(name) =>
      "Are you sure you want to delete the subscription group ${name}?";

  static String m1(fileName) => "Data exported to ${fileName}";

  static String m2(fullPath) => "Data exported to ${fullPath}";

  static String m3(timeagoFormat) => "Ended ${timeagoFormat}";

  static String m4(timeagoFormat) => "Ends ${timeagoFormat}";

  static String m5(snapshotData) => "Finished with ${snapshotData} users";

  static String m6(snapshotData) => "Imported ${snapshotData} users so far";

  static String m7(date) => "Joined ${date}";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: 'no votes', one: 'one vote', two: 'two votes', few: '${numFormatted} votes', many: '${numFormatted} vote', other: '${numFormatted} votes')}";

  static String m9(errorMessage) =>
      "Please check your Internet connection.\n\n${errorMessage}";

  static String m10(releaseVersion) => "Tap to download ${releaseVersion}";

  static String m11(getMediaType) => "Tap to show ${getMediaType}";

  static String m12(state) => "The connection state ${state} is not supported";

  static String m13(filePath) =>
      "The file does not exist. Please ensure it is located at ${filePath}";

  static String m14(thisTweetUserName) => "${thisTweetUserName} retweeted";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'no tweets', one: 'one tweet', two: 'two tweets', few: '${numFormatted} tweets', many: '${numFormatted} tweet', other: '${numFormatted} tweets')}";

  static String m16(widgetPlaceName) =>
      "Unable to load the trends for ${widgetPlaceName}";

  static String m17(e) =>
      "Unable to refresh the subscriptions. The error was ${e}";

  static String m18(responseStatusCode) =>
      "Unable to save the media. Twitter returned a status of ${responseStatusCode}";

  static String m19(e) => "Unable to send the ping. ${e}";

  static String m20(statusCode) =>
      "Unable to send the ping. The status code was ${statusCode}";

  static String m21(releaseVersion) =>
      "Update to ${releaseVersion} through your F-Droid client";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Account suspended"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("Add to group"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "All the great software used by Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "An error was reported to Sentry. Thank you!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "An update for Fritter is available! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Blue theme based on the Twitter color scheme"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Catastrophic failure"),
        "contribute": MessageLookupByLibrary.simpleMessage("Contribute"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Copied address to clipboard"),
        "copied_version_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Copied version to clipboard"),
        "could_not_contact_twitter":
            MessageLookupByLibrary.simpleMessage("Could not contact Twitter"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Couldn\'t find any tweets by this user!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Couldn\'t find any tweets from the last 7 days!"),
        "country": MessageLookupByLibrary.simpleMessage("Country"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "data": MessageLookupByLibrary.simpleMessage("Data"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("Data imported successfully"),
        "date_created": MessageLookupByLibrary.simpleMessage("Date Created"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Date Subscribed"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Default tab"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "disabled": MessageLookupByLibrary.simpleMessage("Disabled"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Don\'t send"),
        "donate": MessageLookupByLibrary.simpleMessage("Donate"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Downloading media..."),
        "enable_sentry": MessageLookupByLibrary.simpleMessage("Enable Sentry?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username":
            MessageLookupByLibrary.simpleMessage("Enter your Twitter username"),
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
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Export your data"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Followers"),
        "following": MessageLookupByLibrary.simpleMessage("Following"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter blue"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "groups": MessageLookupByLibrary.simpleMessage("Groups"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Help make Fritter even better"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Help support Fritter\'s future"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Here is the data that will be sent. It will only be used to determine which devices and languages to support in Fritter in the future."),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "If you have any feedback on this feature, please leave it on"),
        "import": MessageLookupByLibrary.simpleMessage("Import"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Import data from another device"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Import from Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Import subscriptions"),
        "imported_snapshot_data_users_so_far": m6,
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
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("Large"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("Legacy Android Import"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Let the developers know if something\'s broken"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licenses"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "live": MessageLookupByLibrary.simpleMessage("LIVE"),
        "logging": MessageLookupByLibrary.simpleMessage("Logging"),
        "media": MessageLookupByLibrary.simpleMessage("Media"),
        "media_size": MessageLookupByLibrary.simpleMessage("Media size"),
        "medium": MessageLookupByLibrary.simpleMessage("Medium"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "never_send": MessageLookupByLibrary.simpleMessage("Never send"),
        "newTrans": MessageLookupByLibrary.simpleMessage("New"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "No data was returned, which should never happen. Please report a bug, if possible!"),
        "no_results": MessageLookupByLibrary.simpleMessage("No results"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "No subscriptions. Try searching or importing some!"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Note: Due to a Twitter limitation, not all tweets may be included"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oops_something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Oops! Something went wrong 🥲"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("Pick a color!"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Pinned tweet"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Playback speed"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Please enter a name"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Please make sure the data you wish to import is located there, then press the import button below."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Please note that the method Fritter uses to import subscriptions is heavily rate-limited by Twitter, so this may fail if you have a lot of followed accounts."),
        "prefix": MessageLookupByLibrary.simpleMessage("prefix"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Private profile"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "Released under the MIT License"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Replying to"),
        "report": MessageLookupByLibrary.simpleMessage("Report"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Report a bug"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Reporting an error"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Save bandwidth using smaller images"),
        "saved": MessageLookupByLibrary.simpleMessage("Saved"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Say Hello"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Say Hello 👋"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "Selecting individual accounts to import, and assigning groups are both planned for the future already!"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Send a non-identifying ping to let me know you\'re using Fritter, and to help future development"),
        "send_always": MessageLookupByLibrary.simpleMessage("Send always"),
        "send_once": MessageLookupByLibrary.simpleMessage("Send once"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("Share tweet content"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Share tweet link"),
        "small": MessageLookupByLibrary.simpleMessage("Small"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("Something broke in Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Something just went wrong in Fritter, and an error report has been generated. The report can be sent to the Fritter developers to help fix the problem."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Sorry, the replied tweet could not be found!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Subscriptions"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Subtitles"),
        "successfully_saved_the_media": MessageLookupByLibrary.simpleMessage(
            "Successfully saved the media!"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Thanks for helping Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Thanks for reporting. We\'ll try and fix it in no time!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "The tweet did not contain any text. This is unexpected"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "There were no trends returned. This is unexpected! Please report as a bug, if possible."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "This group contains no subscriptions!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "This took too long to load. Please check your network connection!"),
        "this_tweet_is_unavailable":
            MessageLookupByLibrary.simpleMessage("This tweet is unavailable"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "This user does not follow anyone!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "This user does not have anyone following them!"),
        "thread": MessageLookupByLibrary.simpleMessage("Thread"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Thumbnail"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Timed out"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Timed out trying to send the ping 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "To import subscriptions from an existing Twitter account, enter your username below."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Toggle All"),
        "trending": MessageLookupByLibrary.simpleMessage("Trending"),
        "trends": MessageLookupByLibrary.simpleMessage("Trends"),
        "true_black": MessageLookupByLibrary.simpleMessage("True Black?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweets"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweets & Replies"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "Unable to check if this is a legacy Android device."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage(
                "Unable to find the app\'s package info"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Unable to find the available trend locations."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Unable to find your saved tweets."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Unable to import"),
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
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Unable to load the tweet"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("Unable to load the tweets"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load the tweets for the feed"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Unable to run the database migrations"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Unable to stream the trend location preference"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "unsave": MessageLookupByLibrary.simpleMessage("Unsave"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Unsubscribe"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("Updates"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Use true black for the dark mode theme"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("User not found"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "When a new app update is available"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Whether errors should be reported to Sentry"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Which tab is shown when the app opens"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Would you like to enable automatic error reporting?"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "You haven\'t saved any tweets yet!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Your device is running a version of Android older than KitKat (4.4), so data can only be imported from:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Your device is running a version of Android older than KitKat (4.4), so the export can only be saved to:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Your profile must be public, otherwise the import will not work"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Your report will be sent to Fritter\'s Sentry project, and privacy details can be found at:")
      };
}
