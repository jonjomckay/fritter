import 'dart:developer';

import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter/material.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/ui/errors.dart';
import 'package:pref/pref.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// This is a slight modification of the SentryHandler built into Catcher, but
/// with support for sending stack traces, and opt-in reporting.
class FritterSentryHandler extends ReportHandler {
  bool? _isSentryEnabled;
  bool _isModalOpen = false;

  final Hub sentryHub;

  FritterSentryHandler({required this.sentryHub, required Stream<bool?> sentryEnabledStream}) {
    // If a user changes the Sentry preference, make sure we know about it
    sentryEnabledStream.listen((value) {
      _isSentryEnabled = value;
    });
  }

  @override
  Future<bool> handle(Report error, BuildContext? context) async {
    // Whether we should send the error report this time, or not, as we have 4 outcomes
    bool sendThisTime = _isSentryEnabled ?? false;
    if (!sendThisTime) {
      // If the user clicked the manual report button, ignore any stored preference
      sendThisTime = error.error is ManuallyReportedException;
    }

    // If we have a UI context, and the user hasn't configured if Sentry should be used
    if (context != null && _isSentryEnabled == null) {
      if (_isModalOpen) {
        return true;
      }

      await showDialog(
          context: context,
          builder: (context) {
            _isModalOpen = true;

            return AlertDialog(
              title: Text(L10n.of(context).reporting_an_error),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.of(context).something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    L10n.of(context).would_you_like_to_enable_automatic_error_reporting,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    L10n.of(context).your_report_will_be_sent_to_fritter_sentry_project,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    child: const Text('https://fritter.cc/privacy', style: TextStyle(color: Colors.blue)),
                    onTap: () async => await launch('https://fritter.cc/privacy'),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    sendThisTime = true;
                    Navigator.pop(context);
                  },
                  child: Text(L10n.of(context).send_once),
                ),
                TextButton(
                  onPressed: () {
                    sendThisTime = true;
                    PrefService.of(context).set(optionErrorsSentryEnabled, true);
                    Navigator.pop(context);
                  },
                  child: Text(L10n.of(context).send_always),
                ),
                TextButton(
                  onPressed: () {
                    sendThisTime = false;
                    Navigator.pop(context);
                  },
                  child: Text(L10n.of(context).don_not_send),
                ),
                TextButton(
                  onPressed: () {
                    sendThisTime = false;
                    PrefService.of(context).set(optionErrorsSentryEnabled, false);
                    Navigator.pop(context);
                  },
                  child: Text(L10n.of(context).never_send),
                )
              ],
            );
          },
          routeSettings: const RouteSettings(name: 'sentryRoute'));

      _isModalOpen = false;
    }

    if (sendThisTime == false) {
      return true;
    }

    try {
      var nestedError = error.error;
      if (nestedError is ManuallyReportedException) {
        error = Report(
            nestedError.exception,
            error.stackTrace,
            error.dateTime,
            error.deviceParameters,
            error.applicationParameters,
            error.customParameters,
            error.errorDetails,
            error.platformType,
            error.screenshot);
      }

      final tags = <String, dynamic>{};
      tags.addAll(error.applicationParameters);
      tags.addAll(error.customParameters);
      tags.addAll(error.deviceParameters);

      final event = buildEvent(error, tags);
      await sentryHub.captureEvent(event, stackTrace: error.stackTrace);

      if (context != null) {
        var isEnabled = _isSentryEnabled;
        if (isEnabled != null && isEnabled) {
          showSnackBar(context, icon: '🕵️', message: L10n.of(context).an_error_was_reported_to_sentry_thank_you);
        }

        if (isEnabled == null || isEnabled == false) {
          showSnackBar(context,
              icon: '💖', message: L10n.of(context).thanks_for_reporting_we_will_try_and_fix_it_in_no_time);
        }
      }

      return true;
    } catch (e, stackTrace) {
      log('Failed to send Sentry event', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  List<PlatformType> getSupportedPlatforms() {
    return [
      PlatformType.android,
      PlatformType.iOS,
      PlatformType.web,
      PlatformType.linux,
      PlatformType.macOS,
      PlatformType.windows,
    ];
  }

  String _getApplicationVersion(Report report) {
    String applicationVersion = "";
    final applicationParameters = report.applicationParameters;
    if (applicationParameters.containsKey("appName")) {
      applicationVersion += (applicationParameters["appName"] as String?)!;
    }
    if (applicationParameters.containsKey("version")) {
      applicationVersion += " ${applicationParameters["version"]}";
    }
    if (applicationVersion.isEmpty) {
      applicationVersion = "?";
    }
    return applicationVersion;
  }

  SentryEvent buildEvent(Report report, Map<String, dynamic> tags) {
    return SentryEvent(
      release: _getApplicationVersion(report),
      environment: report.applicationParameters["environment"] as String?,
      throwable: report.error,
      level: SentryLevel.error,
      tags: changeToSentryMap(tags),
    );
  }

  Map<String, String> changeToSentryMap(Map<String, dynamic> map) {
    final sentryMap = <String, String>{};
    map.forEach((key, dynamic value) {
      if (value.toString().isEmpty) {
        sentryMap[key] = "none";
      } else {
        sentryMap[key] = value.toString();
      }
    });
    return sentryMap;
  }
}
