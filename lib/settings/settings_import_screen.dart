import 'dart:convert';

import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
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

                    var subscriptions = data.subscriptions;
                    if (subscriptions != null) {
                      await model.importSubscriptions(subscriptions);
                    }

                    Map<String, String> groupMappings = {};

                    var subscriptionGroups = data.subscriptionGroups;
                    if (subscriptionGroups != null) {
                      groupMappings = await model.importSubscriptionGroups(subscriptionGroups);
                    }

                    var subscriptionGroupMembers = data.subscriptionGroupMembers;
                    if (subscriptionGroupMembers != null) {
                      await model.importSubscriptionGroupMembers(subscriptionGroupMembers, groupMappings);
                    }

                    var tweets = data.tweets;
                    if (tweets != null) {
                      await model.importTweets(tweets);
                    }

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
