import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/database/repository.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class SettingsImportScreen extends StatefulWidget {
  const SettingsImportScreen({Key? key}) : super(key: key);

  @override
  _SettingsImportScreenState createState() => _SettingsImportScreenState();
}

class _SettingsImportScreenState extends State<SettingsImportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import'),
      ),
      body: Center(
        child: FutureBuilder<AndroidDeviceInfo>(
          future: DeviceInfoPlugin().androidInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }

            Widget legacyAndroidMessage = Container();

            // Check if the platform is too old to support a directory picker or not
            var deviceInfo = snapshot.data;
            if (deviceInfo == null || deviceInfo.version.sdkInt < 19) {
              legacyAndroidMessage = FutureBuilder<String>(
                future: getLegacyExportPath(),
                builder: (context, snapshot) {
                  var legacyExportPath = snapshot.data;
                  if (legacyExportPath == null) {
                    return CircularProgressIndicator();
                  }

                  return Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text('Your device is running a version of Android older than KitKat (4.4), so data can only be imported from:',
                            textAlign: TextAlign.center),
                        SizedBox(height: 8),
                        Text(legacyExportPath,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                legacyAndroidMessage,
                ElevatedButton(
                    child: Text('Import'),
                    onPressed: () async {
                      var importFromFile = (File file) async {
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

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Data imported successfully'),
                        ));
                      };

                      var platformInfo = await DeviceInfoPlugin().androidInfo;
                      if (platformInfo != null && platformInfo.version.sdkInt < 19) {
                        await importFromFile(File(await getLegacyExportPath()));
                      } else {
                        await FilePickerWritable().openFile((fileInfo, file) async {
                          await importFromFile(file);
                        });
                      }
                    }
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
