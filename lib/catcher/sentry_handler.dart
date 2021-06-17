import 'dart:developer';

import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
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

    // If we have a UI context, and the user hasn't configured if Sentry should be used
    if (context != null && _isSentryEnabled == null) {
      if (_isModalOpen) {
        return true;
      }

      await showDialog(context: context, builder: (context) {
        _isModalOpen = true;

        return AlertDialog(
          title: Text('Reporting an error'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Something just went wrong in Fritter, and an error report has been generated. The report can be sent to the Fritter developers to help fix the problem.'),
              SizedBox(height: 16),
              Text('Would you like to enable automatic error reporting?'),
              SizedBox(height: 16),
              Text('Your report will be sent to Fritter\'s Sentry project, and privacy details can be found at:'),
              SizedBox(height: 16),
              InkWell(
                child: Text('https://fritter.cc/privacy', style: TextStyle(
                  color: Colors.blue
                )),
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
              child: Text('Send once'),
            ),
            TextButton(
              onPressed: () {
                sendThisTime = true;
                PrefService.of(context).set(OPTION_ERRORS_SENTRY_ENABLED, true);
                Navigator.pop(context);
              },
              child: Text('Send always'),
            ),
            TextButton(
              onPressed: () {
                sendThisTime = false;
                Navigator.pop(context);
              },
              child: Text("Don't send"),
            ),
            TextButton(
              onPressed: () {
                sendThisTime = false;
                PrefService.of(context).set(OPTION_ERRORS_SENTRY_ENABLED, false);
                Navigator.pop(context);
              },
              child: Text('Never send'),
            )
          ],
        );
      }, routeSettings: RouteSettings(
        name: 'sentryRoute'
      ));

      _isModalOpen = false;
    }

    if (sendThisTime == false) {
      return true;
    }

    try {
      final tags = <String, dynamic>{};
      tags.addAll(error.applicationParameters);
      tags.addAll(error.customParameters);
      tags.addAll(error.deviceParameters);

      final event = buildEvent(error, tags);
      await sentryHub.captureEvent(event, stackTrace: error.stackTrace);

      if (context != null) {
        var isEnabled = _isSentryEnabled;
        if (isEnabled != null && isEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('An error was reported to Sentry. Thank you!'),
                Text('🕵️'),
              ],
            ),
          ));
        }

        if (isEnabled == null || isEnabled == false) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thanks for reporting. We'll try and fix it in no time!"),
                Text('💖'),
              ],
            ),
          ));
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
