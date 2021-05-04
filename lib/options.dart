import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class OptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  String _createVersionString(PackageInfo packageInfo) {
    return 'v${packageInfo.version}+${packageInfo.buildNumber}';
  }

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

        PrefTitle(
          title: Text('About')
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Text('');
            }

            var version = _createVersionString(data);

            return PrefLabel(
              leading: Icon(Icons.info),
              title: Text('Version'),
              subtitle: Text(version),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: version));

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Copied version to clipboard'),
                ));
              },
            );
          },
        ),
        PrefLabel(
          leading: Icon(Icons.favorite),
          title: Text('Contribute'),
          subtitle: Text('Help make Fritter even better'),
          onTap: () => launch('https://github.com/jonjomckay/fritter'),
        ),
        PrefLabel(
          leading: Icon(Icons.bug_report),
          title: Text('Report a bug'),
          subtitle: Text('Let the developers know if something\'s broken'),
          onTap: () => launch('https://github.com/jonjomckay/fritter/issues'),
        ),
        PrefLabel(
          leading: Icon(Icons.attach_money),
          title: Text('Donate'),
          subtitle: Text('Help support Fritter\'s future'),
          onTap: () => showDialog(context: context, builder: (context) {
            return SimpleDialog(
              title: Text('Donate'),
              children: [
                SimpleDialogOption(
                  child: ListTile(
                    leading: Icon(SimpleIcons.bitcoin),
                    title: Text('Bitcoin'),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: '1DaXsBJVi41fgKkKcw2Ln8noygTbdD7Srg'));

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Copied address to clipboard'),
                    ));
                  },
                ),
                SimpleDialogOption(
                  child: ListTile(
                    leading: Icon(SimpleIcons.github),
                    title: Text('GitHub'),
                  ),
                  onPressed: () => launch('https://github.com/sponsors/jonjomckay'),
                ),
                SimpleDialogOption(
                  child: ListTile(
                    leading: Icon(SimpleIcons.liberapay),
                    title: Text('Liberapay'),
                  ),
                  onPressed: () => launch('https://liberapay.com/jonjomckay'),
                ),
                SimpleDialogOption(
                  child: ListTile(
                    leading: Icon(SimpleIcons.paypal),
                    title: Text('PayPal'),
                  ),
                  onPressed: () => launch('https://paypal.me/jonjomckay'),
                )
              ],
            );
          }),
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Text('');
            }

            var version = _createVersionString(data);

            return PrefLabel(
              leading: Icon(Icons.copyright),
              title: Text('Licenses'),
              subtitle: Text('All the great software used by Fritter'),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'Fritter',
                applicationVersion: version,
                applicationLegalese: 'Released under the MIT License',
                applicationIcon: Container(
                  margin: EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48.0),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 48.0,
                      width: 48.0,
                    ),
                  ),
                )
              ),
            );
          },
        ),
      ]),
    );
  }
}