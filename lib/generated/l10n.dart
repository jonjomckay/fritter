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

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
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

  /// `Joined {date}`
  String joined(Object date) {
    return Intl.message(
      'Joined $date',
      name: 'joined',
      desc: '',
      args: [date],
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
  String get say_hello_emoji {
    return Intl.message(
      'Say Hello 👋',
      name: 'say_hello_emoji',
      desc: '',
      args: [],
    );
  }

  /// `Say Hello`
  String get say_hello {
    return Intl.message(
      'Say Hello',
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

  /// `Send a non-identifying ping to let me know you're using Fritter, and to help future development`
  String
      get send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development {
    return Intl.message(
      'Send a non-identifying ping to let me know you\'re using Fritter, and to help future development',
      name:
          'send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Default tab`
  String get default_tab {
    return Intl.message(
      'Default tab',
      name: 'default_tab',
      desc: '',
      args: [],
    );
  }

  /// `Which tab is shown when the app opens`
  String get which_tab_is_shown_when_the_app_opens {
    return Intl.message(
      'Which tab is shown when the app opens',
      name: 'which_tab_is_shown_when_the_app_opens',
      desc: '',
      args: [],
    );
  }

  /// `Media size`
  String get media_size {
    return Intl.message(
      'Media size',
      name: 'media_size',
      desc: '',
      args: [],
    );
  }

  /// `Save bandwidth using smaller images`
  String get save_bandwidth_using_smaller_images {
    return Intl.message(
      'Save bandwidth using smaller images',
      name: 'save_bandwidth_using_smaller_images',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Thumbnail`
  String get thumbnail {
    return Intl.message(
      'Thumbnail',
      name: 'thumbnail',
      desc: '',
      args: [],
    );
  }

  /// `Small`
  String get small {
    return Intl.message(
      'Small',
      name: 'small',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Large`
  String get large {
    return Intl.message(
      'Large',
      name: 'large',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `True Black?`
  String get true_black {
    return Intl.message(
      'True Black?',
      name: 'true_black',
      desc: '',
      args: [],
    );
  }

  /// `Use true black for the dark mode theme`
  String get use_true_black_for_the_dark_mode_theme {
    return Intl.message(
      'Use true black for the dark mode theme',
      name: 'use_true_black_for_the_dark_mode_theme',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get data {
    return Intl.message(
      'Data',
      name: 'data',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Import data from another device`
  String get import_data_from_another_device {
    return Intl.message(
      'Import data from another device',
      name: 'import_data_from_another_device',
      desc: '',
      args: [],
    );
  }

  /// `Legacy Android Import`
  String get legacy_android_import {
    return Intl.message(
      'Legacy Android Import',
      name: 'legacy_android_import',
      desc: '',
      args: [],
    );
  }

  /// `The file does not exist. Please ensure it is located at {filePath}`
  String the_file_does_not_exist_please_ensure_it_is_located_at_file_path(
      Object filePath) {
    return Intl.message(
      'The file does not exist. Please ensure it is located at $filePath',
      name: 'the_file_does_not_exist_please_ensure_it_is_located_at_file_path',
      desc: '',
      args: [filePath],
    );
  }

  /// `prefix`
  String get prefix {
    return Intl.message(
      'prefix',
      name: 'prefix',
      desc: '',
      args: [],
    );
  }

  /// `Your device is running a version of Android older than KitKat (4.4), so data can only be imported from:`
  String
      get your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from {
    return Intl.message(
      'Your device is running a version of Android older than KitKat (4.4), so data can only be imported from:',
      name:
          'your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure the data you wish to import is located there, then press the import button below.`
  String
      get please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below {
    return Intl.message(
      'Please make sure the data you wish to import is located there, then press the import button below.',
      name:
          'please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below',
      desc: '',
      args: [],
    );
  }

  /// `Export your data`
  String get export_your_data {
    return Intl.message(
      'Export your data',
      name: 'export_your_data',
      desc: '',
      args: [],
    );
  }

  /// `Logging`
  String get logging {
    return Intl.message(
      'Logging',
      name: 'logging',
      desc: '',
      args: [],
    );
  }

  /// `Enable Sentry?`
  String get enable_sentry {
    return Intl.message(
      'Enable Sentry?',
      name: 'enable_sentry',
      desc: '',
      args: [],
    );
  }

  /// `Whether errors should be reported to Sentry`
  String get whether_errors_should_be_reported_to_sentry {
    return Intl.message(
      'Whether errors should be reported to Sentry',
      name: 'whether_errors_should_be_reported_to_sentry',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Copied version to clipboard`
  String get copied_version_to_clipboard {
    return Intl.message(
      'Copied version to clipboard',
      name: 'copied_version_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Contribute`
  String get contribute {
    return Intl.message(
      'Contribute',
      name: 'contribute',
      desc: '',
      args: [],
    );
  }

  /// `Help make Fritter even better`
  String get help_make_fritter_even_better {
    return Intl.message(
      'Help make Fritter even better',
      name: 'help_make_fritter_even_better',
      desc: '',
      args: [],
    );
  }

  /// `Report a bug`
  String get report_a_bug {
    return Intl.message(
      'Report a bug',
      name: 'report_a_bug',
      desc: '',
      args: [],
    );
  }

  /// `Let the developers know if something's broken`
  String get let_the_developers_know_if_something_is_broken {
    return Intl.message(
      'Let the developers know if something\'s broken',
      name: 'let_the_developers_know_if_something_is_broken',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get donate {
    return Intl.message(
      'Donate',
      name: 'donate',
      desc: '',
      args: [],
    );
  }

  /// `Help support Fritter's future`
  String get help_support_fritters_future {
    return Intl.message(
      'Help support Fritter\'s future',
      name: 'help_support_fritters_future',
      desc: '',
      args: [],
    );
  }

  /// `Copied address to clipboard`
  String get copied_address_to_clipboard {
    return Intl.message(
      'Copied address to clipboard',
      name: 'copied_address_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licenses {
    return Intl.message(
      'Licenses',
      name: 'licenses',
      desc: '',
      args: [],
    );
  }

  /// `All the great software used by Fritter`
  String get all_the_great_software_used_by_fritter {
    return Intl.message(
      'All the great software used by Fritter',
      name: 'all_the_great_software_used_by_fritter',
      desc: '',
      args: [],
    );
  }

  /// `Fritter`
  String get fritter {
    return Intl.message(
      'Fritter',
      name: 'fritter',
      desc: '',
      args: [],
    );
  }

  /// `Released under the MIT License`
  String get released_under_the_mit_license {
    return Intl.message(
      'Released under the MIT License',
      name: 'released_under_the_mit_license',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newTrans {
    return Intl.message(
      'New',
      name: 'newTrans',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the subscription group {name}?`
  String are_you_sure_you_want_to_delete_the_subscription_group_name_of_group(
      Object name) {
    return Intl.message(
      'Are you sure you want to delete the subscription group $name?',
      name:
          'are_you_sure_you_want_to_delete_the_subscription_group_name_of_group',
      desc: '',
      args: [name],
    );
  }

  /// `Toggle All`
  String get toggle_all {
    return Intl.message(
      'Toggle All',
      name: 'toggle_all',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a name`
  String get please_enter_a_name {
    return Intl.message(
      'Please enter a name',
      name: 'please_enter_a_name',
      desc: '',
      args: [],
    );
  }

  /// `Pick a color!`
  String get pick_a_color {
    return Intl.message(
      'Pick a color!',
      name: 'pick_a_color',
      desc: '',
      args: [],
    );
  }

  /// `Import subscriptions`
  String get import_subscriptions {
    return Intl.message(
      'Import subscriptions',
      name: 'import_subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `To import subscriptions from an existing Twitter account, enter your username below.`
  String
      get to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below {
    return Intl.message(
      'To import subscriptions from an existing Twitter account, enter your username below.',
      name:
          'to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below',
      desc: '',
      args: [],
    );
  }

  /// `Please note that the method Fritter uses to import subscriptions is heavily rate-limited by Twitter, so this may fail if you have a lot of followed accounts.`
  String
      get please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts {
    return Intl.message(
      'Please note that the method Fritter uses to import subscriptions is heavily rate-limited by Twitter, so this may fail if you have a lot of followed accounts.',
      name:
          'please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts',
      desc: '',
      args: [],
    );
  }

  /// `If you have any feedback on this feature, please leave it on`
  String get if_you_have_any_feedback_on_this_feature_please_leave_it_on {
    return Intl.message(
      'If you have any feedback on this feature, please leave it on',
      name: 'if_you_have_any_feedback_on_this_feature_please_leave_it_on',
      desc: '',
      args: [],
    );
  }

  /// `Selecting individual accounts to import, and assigning groups are both planned for the future already!`
  String
      get selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already {
    return Intl.message(
      'Selecting individual accounts to import, and assigning groups are both planned for the future already!',
      name:
          'selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Twitter username`
  String get enter_your_twitter_username {
    return Intl.message(
      'Enter your Twitter username',
      name: 'enter_your_twitter_username',
      desc: '',
      args: [],
    );
  }

  /// `Your profile must be public, otherwise the import will not work`
  String get your_profile_must_be_public_otherwise_the_import_will_not_work {
    return Intl.message(
      'Your profile must be public, otherwise the import will not work',
      name: 'your_profile_must_be_public_otherwise_the_import_will_not_work',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Unable to import`
  String get unable_to_import {
    return Intl.message(
      'Unable to import',
      name: 'unable_to_import',
      desc: '',
      args: [],
    );
  }

  /// `Imported {snapshotData} users so far`
  String imported_snapshot_data_users_so_far(Object snapshotData) {
    return Intl.message(
      'Imported $snapshotData users so far',
      name: 'imported_snapshot_data_users_so_far',
      desc: '',
      args: [snapshotData],
    );
  }

  /// `Finished with {snapshotData} users`
  String finished_with_snapshotData_users(Object snapshotData) {
    return Intl.message(
      'Finished with $snapshotData users',
      name: 'finished_with_snapshotData_users',
      desc: '',
      args: [snapshotData],
    );
  }

  /// `No subscriptions. Try searching or importing some!`
  String get no_subscriptions_try_searching_or_importing_some {
    return Intl.message(
      'No subscriptions. Try searching or importing some!',
      name: 'no_subscriptions_try_searching_or_importing_some',
      desc: '',
      args: [],
    );
  }

  /// `Import from Twitter`
  String get import_from_twitter {
    return Intl.message(
      'Import from Twitter',
      name: 'import_from_twitter',
      desc: '',
      args: [],
    );
  }

  /// `Unable to refresh the subscriptions. The error was {e}`
  String unable_to_refresh_the_subscriptions_the_error_was_e(Object e) {
    return Intl.message(
      'Unable to refresh the subscriptions. The error was $e',
      name: 'unable_to_refresh_the_subscriptions_the_error_was_e',
      desc: '',
      args: [e],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Date Created`
  String get date_created {
    return Intl.message(
      'Date Created',
      name: 'date_created',
      desc: '',
      args: [],
    );
  }

  /// `Date Subscribed`
  String get date_subscribed {
    return Intl.message(
      'Date Subscribed',
      name: 'date_subscribed',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the trends for {widgetPlaceName}`
  String unable_to_load_the_trends_for_widget_place_name(
      Object widgetPlaceName) {
    return Intl.message(
      'Unable to load the trends for $widgetPlaceName',
      name: 'unable_to_load_the_trends_for_widget_place_name',
      desc: '',
      args: [widgetPlaceName],
    );
  }

  /// `There were no trends returned. This is unexpected! Please report as a bug, if possible.`
  String
      get there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible {
    return Intl.message(
      'There were no trends returned. This is unexpected! Please report as a bug, if possible.',
      name:
          'there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible',
      desc: '',
      args: [],
    );
  }

  /// `Unable to find the available trend locations.`
  String get unable_to_find_the_available_trend_locations {
    return Intl.message(
      'Unable to find the available trend locations.',
      name: 'unable_to_find_the_available_trend_locations',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Unable to stream the trend location preference`
  String get unable_to_stream_the_trend_location_preference {
    return Intl.message(
      'Unable to stream the trend location preference',
      name: 'unable_to_stream_the_trend_location_preference',
      desc: '',
      args: [],
    );
  }

  /// `Trends`
  String get trends {
    return Intl.message(
      'Trends',
      name: 'trends',
      desc: '',
      args: [],
    );
  }

  /// `{num, plural, zero{no tweets} one{one tweet} two{two tweets} few{{numFormatted} tweets} many{{numFormatted} tweet} other{{numFormatted} tweets}}`
  String tweets_number(num num, Object numFormatted) {
    return Intl.plural(
      num,
      zero: 'no tweets',
      one: 'one tweet',
      two: 'two tweets',
      few: '$numFormatted tweets',
      many: '$numFormatted tweet',
      other: '$numFormatted tweets',
      name: 'tweets_number',
      desc: '',
      args: [num, numFormatted],
    );
  }

  /// `Ended {timeagoFormat}`
  String ended_timeago_format_endsAt_allowFromNow_true(Object timeagoFormat) {
    return Intl.message(
      'Ended $timeagoFormat',
      name: 'ended_timeago_format_endsAt_allowFromNow_true',
      desc: '',
      args: [timeagoFormat],
    );
  }

  /// `Ends {timeagoFormat}`
  String ends_timeago_format_endsAt_allowFromNow_true(Object timeagoFormat) {
    return Intl.message(
      'Ends $timeagoFormat',
      name: 'ends_timeago_format_endsAt_allowFromNow_true',
      desc: '',
      args: [timeagoFormat],
    );
  }

  /// `{num, plural, zero{no votes} one{one vote} two{two votes} few{{numFormatted} votes} many{{numFormatted} vote} other{{numFormatted} votes}}`
  String numberFormat_format_total_votes(num num, Object numFormatted) {
    return Intl.plural(
      num,
      zero: 'no votes',
      one: 'one vote',
      two: 'two votes',
      few: '$numFormatted votes',
      many: '$numFormatted vote',
      other: '$numFormatted votes',
      name: 'numberFormat_format_total_votes',
      desc: '',
      args: [num, numFormatted],
    );
  }

  /// `Tap to show {getMediaType}`
  String tap_to_show_getMediaType_item_type(Object getMediaType) {
    return Intl.message(
      'Tap to show $getMediaType',
      name: 'tap_to_show_getMediaType_item_type',
      desc: '',
      args: [getMediaType],
    );
  }

  /// `Unable to save the media. Twitter returned a status of {responseStatusCode}`
  String
      unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode(
          Object responseStatusCode) {
    return Intl.message(
      'Unable to save the media. Twitter returned a status of $responseStatusCode',
      name:
          'unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode',
      desc: '',
      args: [responseStatusCode],
    );
  }

  /// `Downloading media...`
  String get downloading_media {
    return Intl.message(
      'Downloading media...',
      name: 'downloading_media',
      desc: '',
      args: [],
    );
  }

  /// `Successfully saved the media!`
  String get successfully_saved_the_media {
    return Intl.message(
      'Successfully saved the media!',
      name: 'successfully_saved_the_media',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Playback speed`
  String get playback_speed {
    return Intl.message(
      'Playback speed',
      name: 'playback_speed',
      desc: '',
      args: [],
    );
  }

  /// `Subtitles`
  String get subtitles {
    return Intl.message(
      'Subtitles',
      name: 'subtitles',
      desc: '',
      args: [],
    );
  }

  /// `LIVE`
  String get live {
    return Intl.message(
      'LIVE',
      name: 'live',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `{thisTweetUserName} retweeted`
  String this_tweet_user_name_retweeted(Object thisTweetUserName) {
    return Intl.message(
      '$thisTweetUserName retweeted',
      name: 'this_tweet_user_name_retweeted',
      desc: '',
      args: [thisTweetUserName],
    );
  }

  /// `Sorry, the replied tweet could not be found!`
  String get sorry_the_replied_tweet_could_not_be_found {
    return Intl.message(
      'Sorry, the replied tweet could not be found!',
      name: 'sorry_the_replied_tweet_could_not_be_found',
      desc: '',
      args: [],
    );
  }

  /// `Replying to`
  String get replying_to {
    return Intl.message(
      'Replying to',
      name: 'replying_to',
      desc: '',
      args: [],
    );
  }

  /// `The tweet did not contain any text. This is unexpected`
  String get the_tweet_did_not_contain_any_text_this_is_unexpected {
    return Intl.message(
      'The tweet did not contain any text. This is unexpected',
      name: 'the_tweet_did_not_contain_any_text_this_is_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `This tweet is unavailable`
  String get this_tweet_is_unavailable {
    return Intl.message(
      'This tweet is unavailable',
      name: 'this_tweet_is_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Pinned tweet`
  String get pinned_tweet {
    return Intl.message(
      'Pinned tweet',
      name: 'pinned_tweet',
      desc: '',
      args: [],
    );
  }

  /// `Thread`
  String get thread {
    return Intl.message(
      'Thread',
      name: 'thread',
      desc: '',
      args: [],
    );
  }

  /// `Unsave`
  String get unsave {
    return Intl.message(
      'Unsave',
      name: 'unsave',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Share tweet content`
  String get share_tweet_content {
    return Intl.message(
      'Share tweet content',
      name: 'share_tweet_content',
      desc: '',
      args: [],
    );
  }

  /// `Share tweet link`
  String get share_tweet_link {
    return Intl.message(
      'Share tweet link',
      name: 'share_tweet_link',
      desc: '',
      args: [],
    );
  }

  /// `Private profile`
  String get private_profile {
    return Intl.message(
      'Private profile',
      name: 'private_profile',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Account suspended`
  String get account_suspended {
    return Intl.message(
      'Account suspended',
      name: 'account_suspended',
      desc: '',
      args: [],
    );
  }

  /// `Catastrophic failure`
  String get catastrophic_failure {
    return Intl.message(
      'Catastrophic failure',
      name: 'catastrophic_failure',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Could not contact Twitter`
  String get could_not_contact_twitter {
    return Intl.message(
      'Could not contact Twitter',
      name: 'could_not_contact_twitter',
      desc: '',
      args: [],
    );
  }

  /// `Please check your Internet connection.\n\n{errorMessage}`
  String please_check_your_internet_connection_error_message(
      Object errorMessage) {
    return Intl.message(
      'Please check your Internet connection.\n\n$errorMessage',
      name: 'please_check_your_internet_connection_error_message',
      desc: '',
      args: [errorMessage],
    );
  }

  /// `Timed out`
  String get timed_out {
    return Intl.message(
      'Timed out',
      name: 'timed_out',
      desc: '',
      args: [],
    );
  }

  /// `This took too long to load. Please check your network connection!`
  String get this_took_too_long_to_load_please_check_your_network_connection {
    return Intl.message(
      'This took too long to load. Please check your network connection!',
      name: 'this_took_too_long_to_load_please_check_your_network_connection',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong 🥲`
  String get oops_something_went_wrong {
    return Intl.message(
      'Oops! Something went wrong 🥲',
      name: 'oops_something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `No data was returned, which should never happen. Please report a bug, if possible!`
  String
      get no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible {
    return Intl.message(
      'No data was returned, which should never happen. Please report a bug, if possible!',
      name:
          'no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible',
      desc: '',
      args: [],
    );
  }

  /// `The connection state {state} is not supported`
  String the_connection_state_state_is_not_supported(Object state) {
    return Intl.message(
      'The connection state $state is not supported',
      name: 'the_connection_state_state_is_not_supported',
      desc: '',
      args: [state],
    );
  }

  /// `Updates`
  String get updates {
    return Intl.message(
      'Updates',
      name: 'updates',
      desc: '',
      args: [],
    );
  }

  /// `When a new app update is available`
  String get when_a_new_app_update_is_available {
    return Intl.message(
      'When a new app update is available',
      name: 'when_a_new_app_update_is_available',
      desc: '',
      args: [],
    );
  }

  /// `An update for Fritter is available! 🚀`
  String get an_update_for_fritter_is_available {
    return Intl.message(
      'An update for Fritter is available! 🚀',
      name: 'an_update_for_fritter_is_available',
      desc: '',
      args: [],
    );
  }

  /// `Tap to download {releaseVersion}`
  String tap_to_download_release_version(Object releaseVersion) {
    return Intl.message(
      'Tap to download $releaseVersion',
      name: 'tap_to_download_release_version',
      desc: '',
      args: [releaseVersion],
    );
  }

  /// `Update to {releaseVersion} through your F-Droid client`
  String update_to_release_version_through_your_fdroid_client(
      Object releaseVersion) {
    return Intl.message(
      'Update to $releaseVersion through your F-Droid client',
      name: 'update_to_release_version_through_your_fdroid_client',
      desc: '',
      args: [releaseVersion],
    );
  }

  /// `Fritter blue`
  String get fritter_blue {
    return Intl.message(
      'Fritter blue',
      name: 'fritter_blue',
      desc: '',
      args: [],
    );
  }

  /// `Blue theme based on the Twitter color scheme`
  String get blue_theme_based_on_the_twitter_color_scheme {
    return Intl.message(
      'Blue theme based on the Twitter color scheme',
      name: 'blue_theme_based_on_the_twitter_color_scheme',
      desc: '',
      args: [],
    );
  }

  /// `Something broke in Fritter.`
  String get something_broke_in_fritter {
    return Intl.message(
      'Something broke in Fritter.',
      name: 'something_broke_in_fritter',
      desc: '',
      args: [],
    );
  }

  /// `Unable to run the database migrations`
  String get unable_to_run_the_database_migrations {
    return Intl.message(
      'Unable to run the database migrations',
      name: 'unable_to_run_the_database_migrations',
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
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'nb', countryCode: 'NO'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
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
