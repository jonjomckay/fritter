import 'dart:convert';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                child: Text('Import'),
                onPressed: () async {
                  await FilePickerWritable().openFile((fileInfo, file) async {
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
                  });
                }
            )
          ],
        ),
      ),
    );
  }
}
