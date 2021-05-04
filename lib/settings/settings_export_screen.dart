import 'dart:convert';

import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:intl/intl.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

class SettingsExportScreen extends StatefulWidget {
  const SettingsExportScreen({Key? key}) : super(key: key);

  @override
  _SettingsExportScreenState createState() => _SettingsExportScreenState();
}

class _SettingsExportScreenState extends State<SettingsExportScreen> {
  bool _exportSettings = false;
  bool _exportSubscriptions = false;
  bool _exportSubscriptionGroups = false;
  bool _exportSubscriptionGroupMembers= false;
  bool _exportTweets = false;

  void toggleExportSubscriptionGroupMembersIfRequired() {
    if (_exportSubscriptionGroupMembers && (!_exportSubscriptions || !_exportSubscriptionGroups)) {
      setState(() {
        _exportSubscriptionGroupMembers = false;
      });
    }
  }

  void toggleExportSettings() {
    setState(() {
      _exportSettings = !_exportSettings;
    });
  }

  void toggleExportSubscriptions() {
    setState(() {
      _exportSubscriptions = !_exportSubscriptions;
    });

    toggleExportSubscriptionGroupMembersIfRequired();
  }

  void toggleExportSubscriptionGroups() {
    setState(() {
      _exportSubscriptionGroups = !_exportSubscriptionGroups;
    });

    toggleExportSubscriptionGroupMembersIfRequired();
  }

  void toggleExportSubscriptionGroupMembers() {
    setState(() {
      _exportSubscriptionGroupMembers = !_exportSubscriptionGroupMembers;
    });
  }

  void toggleExportTweets() {
    setState(() {
      _exportTweets = !_exportTweets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckboxListTile(
                value: _exportSettings,
                title: Text('Export settings?'),
                onChanged: (v) => toggleExportSettings()
            ),
            CheckboxListTile(
                value: _exportSubscriptions,
                title: Text('Export subscriptions?'),
                onChanged: (v) => toggleExportSubscriptions()
            ),
            CheckboxListTile(
                value: _exportSubscriptionGroups,
                title: Text('Export subscription groups?'),
                onChanged: (v) => toggleExportSubscriptionGroups()
            ),
            CheckboxListTile(
                value: _exportSubscriptionGroupMembers,
                title: Text('Export subscription group members?'),
                onChanged: _exportSubscriptions && _exportSubscriptionGroups
                  ? (v) => toggleExportSubscriptionGroupMembers()
                  : null
            ),
            CheckboxListTile(
                value: _exportTweets,
                title: Text('Export tweets?'),
                onChanged: (v) => toggleExportTweets()
            ),

            ElevatedButton(
              child: Text('Export'),
              onPressed: () async {
                var model = context.read<HomeModel>();
                var prefs = PrefService.of(context);

                var settings = _exportSettings
                  ? prefs.toMap()
                  : null;

                var subscriptions = _exportSubscriptions
                  ? await model.listSubscriptions(orderBy: 'id', orderByAscending: true)
                  : null;

                var subscriptionGroups = _exportSubscriptionGroups
                  ? await model.listSubscriptionGroups()
                  : null;

                var subscriptionGroupMembers = _exportSubscriptionGroupMembers
                  ? await model.listSubscriptionGroupMembers()
                  : null;

                var tweets = _exportTweets
                  ? await model.listSavedTweets()
                  : null;

                var data = SettingsData(
                    settings: settings,
                    subscriptions: subscriptions,
                    subscriptionGroups: subscriptionGroups,
                    subscriptionGroupMembers: subscriptionGroupMembers,
                    tweets: tweets
                );

                var dateFormat = DateFormat('yyyy-MM-dd');
                var fileName = 'fritter-${dateFormat.format(DateTime.now())}.json';

                await FilePickerWritable().openFileForCreate(fileName: fileName, writer: (file) async {
                  file.writeAsStringSync(jsonEncode(data.toJson()));
                });
              }
            )
          ],
        ),
      ),
    );
  }
}
