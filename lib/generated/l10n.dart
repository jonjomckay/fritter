// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `This group contains no subscriptions!`
  String get this_group_contains_no_subscriptions {
    return Intl.message(
      'This group contains no subscriptions!',
      name: 'this_group_contains_no_subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't find any tweets by this user!`
  String get could_not_find_any_tweets_by_this_user {
    return Intl.message(
      'Couldn\'t find any tweets by this user!',
      name: 'could_not_find_any_tweets_by_this_user',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the next page of replies`
  String get unable_to_load_the_next_page_of_replies {
    return Intl.message(
      'Unable to load the next page of replies',
      name: 'unable_to_load_the_next_page_of_replies',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the tweet`
  String get unable_to_load_the_tweet {
    return Intl.message(
      'Unable to load the tweet',
      name: 'unable_to_load_the_tweet',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load subscription groups`
  String get unable_to_load_subscription_groups {
    return Intl.message(
      'Unable to load subscription groups',
      name: 'unable_to_load_subscription_groups',
      desc: '',
      args: [],
    );
  }

  /// `Add to group`
  String get add_to_group {
    return Intl.message(
      'Add to group',
      name: 'add_to_group',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe`
  String get unsubscribe {
    return Intl.message(
      'Unsubscribe',
      name: 'unsubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Reporting an error`
  String get reporting_an_error {
    return Intl.message(
      'Reporting an error',
      name: 'reporting_an_error',
      desc: '',
      args: [],
    );
  }

  /// `Something just went wrong in Fritter, and an error report has been generated. The report can be sent to the Fritter developers to help fix the problem.`
  String
      get something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated {
    return Intl.message(
      'Something just went wrong in Fritter, and an error report has been generated. The report can be sent to the Fritter developers to help fix the problem.',
      name:
          'something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to enable automatic error reporting?`
  String get would_you_like_to_enable_automatic_error_reporting {
    return Intl.message(
      'Would you like to enable automatic error reporting?',
      name: 'would_you_like_to_enable_automatic_error_reporting',
      desc: '',
      args: [],
    );
  }

  /// `Your report will be sent to Fritter's Sentry project, and privacy details can be found at:`
  String get your_report_will_be_sent_to_fritter_sentry_project {
    return Intl.message(
      'Your report will be sent to Fritter\'s Sentry project, and privacy details can be found at:',
      name: 'your_report_will_be_sent_to_fritter_sentry_project',
      desc: '',
      args: [],
    );
  }

  /// `Send once`
  String get send_once {
    return Intl.message(
      'Send once',
      name: 'send_once',
      desc: '',
      args: [],
    );
  }

  /// `Send always`
  String get send_always {
    return Intl.message(
      'Send always',
      name: 'send_always',
      desc: '',
      args: [],
    );
  }

  /// `Don't send`
  String get don_not_send {
    return Intl.message(
      'Don\'t send',
      name: 'don_not_send',
      desc: '',
      args: [],
    );
  }

  /// `Never send`
  String get never_send {
    return Intl.message(
      'Never send',
      name: 'never_send',
      desc: '',
      args: [],
    );
  }

  /// `An error was reported to Sentry. Thank you!`
  String get an_error_was_reported_to_sentry_thank_you {
    return Intl.message(
      'An error was reported to Sentry. Thank you!',
      name: 'an_error_was_reported_to_sentry_thank_you',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for reporting. We'll try and fix it in no time!`
  String get thanks_for_reporting_we_will_try_and_fix_it_in_no_time {
    return Intl.message(
      'Thanks for reporting. We\'ll try and fix it in no time!',
      name: 'thanks_for_reporting_we_will_try_and_fix_it_in_no_time',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the next page of tweets`
  String get unable_to_load_the_next_page_of_tweets {
    return Intl.message(
      'Unable to load the next page of tweets',
      name: 'unable_to_load_the_next_page_of_tweets',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the tweets for the feed`
  String get unable_to_load_the_tweets_for_the_feed {
    return Intl.message(
      'Unable to load the tweets for the feed',
      name: 'unable_to_load_the_tweets_for_the_feed',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't find any tweets from the last 7 days!`
  String get could_not_find_any_tweets_from_the_last_7_days {
    return Intl.message(
      'Couldn\'t find any tweets from the last 7 days!',
      name: 'could_not_find_any_tweets_from_the_last_7_days',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the group`
  String get unable_to_load_the_group {
    return Intl.message(
      'Unable to load the group',
      name: 'unable_to_load_the_group',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the group settings`
  String get unable_to_load_the_group_settings {
    return Intl.message(
      'Unable to load the group settings',
      name: 'unable_to_load_the_group_settings',
      desc: '',
      args: [],
    );
  }

  /// `Note: Due to a Twitter limitation, not all tweets may be included`
  String get note_due_to_a_twitter_limitation_not_all_tweets_may_be_included {
    return Intl.message(
      'Note: Due to a Twitter limitation, not all tweets may be included',
      name: 'note_due_to_a_twitter_limitation_not_all_tweets_may_be_included',
      desc: '',
      args: [],
    );
  }

  /// `Include replies`
  String get include_replies {
    return Intl.message(
      'Include replies',
      name: 'include_replies',
      desc: '',
      args: [],
    );
  }

  /// `Include retweets`
  String get include_retweets {
    return Intl.message(
      'Include retweets',
      name: 'include_retweets',
      desc: '',
      args: [],
    );
  }

  /// `Unable to find your saved tweets.`
  String get unable_to_find_your_saved_tweets {
    return Intl.message(
      'Unable to find your saved tweets.',
      name: 'unable_to_find_your_saved_tweets',
      desc: '',
      args: [],
    );
  }

  /// `You haven't saved any tweets yet!`
  String get you_have_not_saved_any_tweets_yet {
    return Intl.message(
      'You haven\'t saved any tweets yet!',
      name: 'you_have_not_saved_any_tweets_yet',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the search results.`
  String get unable_to_load_the_search_results {
    return Intl.message(
      'Unable to load the search results.',
      name: 'unable_to_load_the_search_results',
      desc: '',
      args: [],
    );
  }

  /// `No results`
  String get no_results {
    return Intl.message(
      'No results',
      name: 'no_results',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get feed {
    return Intl.message(
      'Feed',
      name: 'feed',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get subscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Trending`
  String get trending {
    return Intl.message(
      'Trending',
      name: 'trending',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the list of follows`
  String get unable_to_load_the_list_of_follows {
    return Intl.message(
      'Unable to load the list of follows',
      name: 'unable_to_load_the_list_of_follows',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the next page of follows`
  String get unable_to_load_the_next_page_of_follows {
    return Intl.message(
      'Unable to load the next page of follows',
      name: 'unable_to_load_the_next_page_of_follows',
      desc: '',
      args: [],
    );
  }

  /// `This user does not follow anyone!`
  String get this_user_does_not_follow_anyone {
    return Intl.message(
      'This user does not follow anyone!',
      name: 'this_user_does_not_follow_anyone',
      desc: '',
      args: [],
    );
  }

  /// `This user does not have anyone following them!`
  String get this_user_does_not_have_anyone_following_them {
    return Intl.message(
      'This user does not have anyone following them!',
      name: 'this_user_does_not_have_anyone_following_them',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the tweets`
  String get unable_to_load_the_tweets {
    return Intl.message(
      'Unable to load the tweets',
      name: 'unable_to_load_the_tweets',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the profile`
  String get unable_to_load_the_profile {
    return Intl.message(
      'Unable to load the profile',
      name: 'unable_to_load_the_profile',
      desc: '',
      args: [],
    );
  }

  /// `Tweets`
  String get tweets {
    return Intl.message(
      'Tweets',
      name: 'tweets',
      desc: '',
      args: [],
    );
  }

  /// `Tweets & Replies`
  String get tweets_and_replies {
    return Intl.message(
      'Tweets & Replies',
      name: 'tweets_and_replies',
      desc: '',
      args: [],
    );
  }

  /// `Media`
  String get media {
    return Intl.message(
      'Media',
      name: 'media',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message(
      'Export',
      name: 'export',
      desc: '',
      args: [],
    );
  }

  /// `Data exported to {fullPath}`
  String data_exported_to_fullPath(Object fullPath) {
    return Intl.message(
      'Data exported to $fullPath',
      name: 'data_exported_to_fullPath',
      desc: '',
      args: [fullPath],
    );
  }

  /// `Data exported to {fileName}`
  String data_exported_to_fileName(Object fileName) {
    return Intl.message(
      'Data exported to $fileName',
      name: 'data_exported_to_fileName',
      desc: '',
      args: [fileName],
    );
  }

  /// `Unable to check if this is a legacy Android device.`
  String get unable_to_check_if_this_is_a_legacy_Android_device {
    return Intl.message(
      'Unable to check if this is a legacy Android device.',
      name: 'unable_to_check_if_this_is_a_legacy_Android_device',
      desc: '',
      args: [],
    );
  }

  /// `Your device is running a version of Android older than KitKat (4.4), so the export can only be saved to:`
  String
      get your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to {
    return Intl.message(
      'Your device is running a version of Android older than KitKat (4.4), so the export can only be saved to:',
      name:
          'your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to',
      desc: '',
      args: [],
    );
  }

  /// `Export settings?`
  String get export_settings {
    return Intl.message(
      'Export settings?',
      name: 'export_settings',
      desc: '',
      args: [],
    );
  }

  /// `Export subscriptions?`
  String get export_subscriptions {
    return Intl.message(
      'Export subscriptions?',
      name: 'export_subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Export subscription groups?`
  String get export_subscription_groups {
    return Intl.message(
      'Export subscription groups?',
      name: 'export_subscription_groups',
      desc: '',
      args: [],
    );
  }

  /// `Export subscription group members?`
  String get export_subscription_group_members {
    return Intl.message(
      'Export subscription group members?',
      name: 'export_subscription_group_members',
      desc: '',
      args: [],
    );
  }

  /// `Export tweets?`
  String get export_tweets {
    return Intl.message(
      'Export tweets?',
      name: 'export_tweets',
      desc: '',
      args: [],
    );
  }

  /// `Data imported successfully`
  String get data_imported_successfully {
    return Intl.message(
      'Data imported successfully',
      name: 'data_imported_successfully',
      desc: '',
      args: [],
    );
  }

  /// `It looks like you've already said hello from this version of Fritter!`
  String
      get it_looks_like_you_have_already_said_hello_from_this_version_of_fritter {
    return Intl.message(
      'It looks like you\'ve already said hello from this version of Fritter!',
      name:
          'it_looks_like_you_have_already_said_hello_from_this_version_of_fritter',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for helping Fritter! 💖`
  String get thanks_for_helping_fritter {
    return Intl.message(
      'Thanks for helping Fritter! 💖',
      name: 'thanks_for_helping_fritter',
      desc: '',
      args: [],
    );
  }

  /// `It looks like you've already sent a ping recently 🤔`
  String get it_looks_like_you_have_already_sent_a_ping_recently {
    return Intl.message(
      'It looks like you\'ve already sent a ping recently 🤔',
      name: 'it_looks_like_you_have_already_sent_a_ping_recently',
      desc: '',
      args: [],
    );
  }

  /// `Unable to send the ping. The status code was {statusCode}`
  String unable_to_send_the_ping_the_status_code_was_response_statusCode(
      Object statusCode) {
    return Intl.message(
      'Unable to send the ping. The status code was $statusCode',
      name: 'unable_to_send_the_ping_the_status_code_was_response_statusCode',
      desc: '',
      args: [statusCode],
    );
  }

  /// `Timed out trying to send the ping 😢`
  String get timed_out_trying_to_send_the_ping {
    return Intl.message(
      'Timed out trying to send the ping 😢',
      name: 'timed_out_trying_to_send_the_ping',
      desc: '',
      args: [],
    );
  }

  /// `Unable to send the ping. {e}`
  String unable_to_send_the_ping_e_to_string(Object e) {
    return Intl.message(
      'Unable to send the ping. $e',
      name: 'unable_to_send_the_ping_e_to_string',
      desc: '',
      args: [e],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Say Hello 👋`
  String get say_hello {
    return Intl.message(
      'Say Hello 👋',
      name: 'say_hello',
      desc: '',
      args: [],
    );
  }

  /// `Here is the data that will be sent. It will only be used to determine which devices and languages to support in Fritter in the future.`
  String
      get here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future {
    return Intl.message(
      'Here is the data that will be sent. It will only be used to determine which devices and languages to support in Fritter in the future.',
      name:
          'here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future',
      desc: '',
      args: [],
    );
  }

  /// `Unable to find the app's package info`
  String get unable_to_find_the_app_package_info {
    return Intl.message(
      'Unable to find the app\'s package info',
      name: 'unable_to_find_the_app_package_info',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
