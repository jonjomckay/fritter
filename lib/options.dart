import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:fritter/settings/settings_export_screen.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

String getFlavor() {
  const flavor = String.fromEnvironment('app.flavor');

  if (flavor == '') {
    return 'fdroid';
  }

  return flavor;
}

class OptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  static final log = Logger('_OptionsScreenState');

  String _createVersionString(PackageInfo packageInfo) {
    return 'v${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future _importFromFile(File file) async {
    var content = jsonDecode(file.readAsStringSync());

    var model = context.read<HomeModel>();
    var prefs = PrefService.of(context);

    var data = SettingsData.fromJson(content);

    var settings = data.settings;
    if (settings != null) {
      prefs.fromMap(settings);
    }

    var dataToImport = Map<String, List<ToMappable>>();

    var subscriptions = data.subscriptions;
    if (subscriptions != null) {
      dataToImport[TABLE_SUBSCRIPTION] = subscriptions;
    }

    var subscriptionGroups = data.subscriptionGroups;
    if (subscriptionGroups != null) {
      dataToImport[TABLE_SUBSCRIPTION_GROUP] = subscriptionGroups;
    }

    var subscriptionGroupMembers = data.subscriptionGroupMembers;
    if (subscriptionGroupMembers != null) {
      dataToImport[TABLE_SUBSCRIPTION_GROUP_MEMBER] = subscriptionGroupMembers;
    }

    var tweets = data.tweets;
    if (tweets != null) {
      dataToImport[TABLE_SAVED_TWEET] = tweets;
    }

    await model.importData(dataToImport);
    await model.refreshSubscriptionUsers();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data imported successfully'),
    ));
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
        'flavor': getFlavor(),
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
        'flavor': getFlavor(),
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

                      // Mark that we've said hello from this build version
                      await prefService.set(OPTION_HELLO_LAST_BUILD, packageInfo.buildNumber);
                    } else if (response.statusCode == 403) {
                      snackBar = SnackBar(
                        content: Text('It looks like you\'ve already sent a ping recently 🤔'),
                      );
                    } else {
                      log.severe('Unable to send the ping');

                      snackBar = SnackBar(
                        content: Text('Unable to send the ping. The status code was ${response.statusCode}'),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } on TimeoutException catch (e, stackTrace) {
                    log.severe('Timed out trying to send the ping', e, stackTrace);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Timed out trying to send the ping 😢'),
                    ));
                  } catch (e, stackTrace) {
                    log.severe('Unable to send', e, stackTrace);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Unable to send the ping. ${e.toString()}'),
                    ));
                  }

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
      body: FutureBuilderWrapper<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        onError: (error, stackTrace) => FullPageErrorWidget(error: error, stackTrace: stackTrace, prefix: "Unable to find the app's package info"),
        onReady: (packageInfo) {
          var version = _createVersionString(packageInfo);

          return PrefPage(children: [
            PrefButton(
              child: Text('👋 Hello'),
              title: Text('Say Hello'),
              subtitle: Text('Send a non-identifying ping to let me know you\'re using Fritter, and to help future development'),
              onTap: _sendPing,
            ),

            PrefTitle(
              title: Text('General'),
            ),
            PrefDropdown(
                fullWidth: false,
                title: Text('Default tab'),
                subtitle: Text('Which tab is shown when the app opens'),
                pref: OPTION_HOME_INITIAL_TAB,
                items: homeTabs
                    .map((e) => DropdownMenuItem(child: Text(e.title), value: e.id))
                    .toList()
            ),
            PrefDropdown(
                fullWidth: false,
                title: Text('Media size'),
                subtitle: Text('Save bandwidth using smaller images'),
                pref: OPTION_MEDIA_SIZE,
                items: [
                  DropdownMenuItem(child: Text('Disabled'), value: 'disabled'),
                  DropdownMenuItem(child: Text('Thumbnail'), value: 'thumb'),
                  DropdownMenuItem(child: Text('Small'), value: 'small'),
                  DropdownMenuItem(child: Text('Medium'), value: 'medium'),
                  DropdownMenuItem(child: Text('Large'), value: 'large'),
                ]
            ),

            PrefTitle(
                title: Text('Theme')
            ),
            PrefDropdown(
                fullWidth: false,
                title: Text('Theme'),
                pref: OPTION_THEME_MODE,
                items: [
                  DropdownMenuItem(child: Text('System'), value: 'system'),
                  DropdownMenuItem(child: Text('Light'), value: 'light'),
                  DropdownMenuItem(child: Text('Dark'), value: 'dark'),
                ]
            ),
            PrefSwitch(
              title: Text('True Black?'),
              pref: OPTION_THEME_TRUE_BLACK,
              subtitle: Text('Use true black for the dark mode theme'),
            ),

            PrefTitle(
              title: Text('Data'),
            ),
            PrefLabel(
              leading: Icon(Icons.import_export),
              title: Text('Import'),
              subtitle: Text('Import data from another device'),
              onTap: () async {
                var isLegacy = await isLegacyAndroid();
                if (isLegacy) {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Legacy Android Import'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text('Import'),
                          onPressed: () async {
                            var file = File(await getLegacyPath(legacyExportFileName));
                            if (await file.exists()) {
                              try {
                                await _importFromFile(file);
                              } catch (e, stackTrace) {
                                log.severe('Unable to import the file on a legacy Android device', e, stackTrace);

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('$e'),
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('The file does not exist. Please ensure it is located at ${file.path}'),
                              ));
                            }

                            Navigator.pop(context);
                          },
                        )
                      ],
                      content: FutureBuilderWrapper<String>(
                        future: getLegacyPath(legacyExportFileName),
                        onError: (error, stackTrace) => FullPageErrorWidget(error: error, stackTrace: stackTrace, prefix: 'prefix'),
                        onReady: (legacyExportPath) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Your device is running a version of Android older than KitKat (4.4), so data can only be imported from:',
                                textAlign: TextAlign.left),
                            SizedBox(height: 16),
                            Text(legacyExportPath,
                                textAlign: TextAlign.left),
                            SizedBox(height: 16),
                            Text('Please make sure the data you wish to import is located there, then press the import button below.',
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    );
                  });
                } else {
                  await FilePickerWritable().openFile((fileInfo, file) async {
                    await _importFromFile(file);
                  });
                }
              },
            ),
            PrefLabel(
              leading: Icon(Icons.save),
              title: Text('Export'),
              subtitle: Text('Export your data'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsExportScreen())),
            ),

            PrefTitle(
              title: Text('Logging')
            ),
            PrefCheckbox(
              title: Text('Enable Sentry?'),
              subtitle: Text('Whether errors should be reported to Sentry'),
              pref: OPTION_ERRORS_SENTRY_ENABLED,
            ),

            PrefTitle(
                title: Text('About')
            ),
            PrefLabel(
              leading: Icon(Icons.info),
              title: Text('Version'),
              subtitle: Text(version),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: version));

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Copied version to clipboard'),
                ));
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
            if (getFlavor() != 'play')
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
            PrefLabel(
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
            ),
          ]);
        },
      ),
    );
  }
}