import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';

import 'constants.dart';

class OptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  Future _sendPing() async {
    var deviceInfo = DeviceInfoPlugin();
    var packageInfo = await PackageInfo.fromPlatform();
    var prefService = PrefService.of(context);

    // If we've already reported using this build number, do nothing
    var helloBuild = prefService.get(OPTION_HELLO_LAST_BUILD);
    if (helloBuild != null && helloBuild == packageInfo.buildNumber) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('It looks like you\'ve already said hello from this version of Fritter!'),
      ));

      return;
    }

    Map<String, Object> metadata;

    if (Platform.isAndroid) {
      var info = await deviceInfo.androidInfo;

      metadata = {
        'abis': info.supportedAbis,
        'device': info.device,
        'locale': Localizations.localeOf(context).languageCode,
        'os': 'android',
        'system': info.version.sdkInt.toString(),
        'version': packageInfo.buildNumber,
      };
    } else {
      var info = await deviceInfo.iosInfo;

      metadata = {
        'abis': [],
        'device': info.utsname.machine,
        'locale': Localizations.localeOf(context).languageCode,
        'os': 'ios',
        'system': info.systemVersion,
        'version': packageInfo.buildNumber,
      };
    }

    showDialog(context: context, builder: (context) {
      var content = JsonEncoder.withIndent(' ' * 2).convert(metadata);

      return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')
            ),
            TextButton(
                onPressed: () async {
                  var pingUri = 'https://fritter.jonjomckay.com/ping';

                  try {
                    var response = await http.post(Uri.parse(pingUri),
                        headers: {
                          'Content-Type': 'application/json'
                        },
                        body: content
                    ).timeout(Duration(seconds: 10));

                    SnackBar snackBar;

                    if (response.statusCode == 200) {
                      snackBar = SnackBar(
                        content: Text('Thanks for helping Fritter! 💖'),
                      );
                    } else if (response.statusCode == 403) {
                      snackBar = SnackBar(
                        content: Text('It looks like you\'ve already sent a ping recently 🤔'),
                      );
                    } else {
                      log('Unable to send the ping');

                      snackBar = SnackBar(
                        content: Text('Unable to send the ping. The status code was ${response.statusCode}'),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } on TimeoutException catch (e, stackTrace) {
                    log('Timed out trying to send the ping', error: e, stackTrace: stackTrace);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Timed out trying to send the ping 😢'),
                    ));
                  } catch (e, stackTrace) {
                    log('Unable to send', error: e, stackTrace: stackTrace);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Unable to send the ping. ${e.toString()}'),
                    ));
                  }

                  await prefService.set(OPTION_HELLO_LAST_BUILD, packageInfo.buildNumber);

                  Navigator.pop(context);
                },
                child: Text('Send')
            )
          ],
          title: Text('Say Hello 👋'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Here is the data that will be sent. It will only be used to determine which devices and languages to support in Fritter in the future.'),
              SizedBox(height: 16),
              Text(content, style: TextStyle(
                  fontFamily: 'monospace'
              ))
            ],
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PrefPage(children: [
        PrefTitle(
          title: Text('General'),
        ),
        PrefButton(
          child: Text('👋 Hello'),
          title: Text('Say Hello'),
          subtitle: Text('Send a non-identifying ping to let me know you\'re using Fritter, and to help future development'),
          onTap: _sendPing,
        ),
        PrefTitle(
            title: Text('Theme')
        ),
        PrefRadio(
          title: Text('System Theme'),
          value: 'system',
          pref: OPTION_THEME_MODE,
        ),
        PrefRadio(
          title: Text('Light Theme'),
          value: 'light',
          pref: OPTION_THEME_MODE,
        ),
        PrefRadio(
          title: Text('Dark Theme'),
          value: 'dark',
          pref: OPTION_THEME_MODE,
        ),
        PrefSwitch(
          title: Text('True Black?'),
          pref: OPTION_THEME_TRUE_BLACK,
          subtitle: Text('Use true black for the dark mode theme'),
        ),
      ]),
    );
  }
}