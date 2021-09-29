import 'dart:convert';
import 'dart:io';

import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/settings/settings_data.dart';
import 'package:fritter/subscriptions/users_model.dart';
import 'package:fritter/ui/errors.dart';
import 'package:fritter/ui/futures.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
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
  bool _exportSubscriptionGroupMembers = false;
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
  
  bool noExportOptionSelected() {
    return !(_exportSettings ||
          _exportSubscriptions ||
          _exportSubscriptionGroups ||
          _exportSubscriptionGroupMembers ||
          _exportTweets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export'),
      ),
      floatingActionButton: noExportOptionSelected()
          ? null
          : FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          var homeModel = context.read<HomeModel>();
          var groupModel = context.read<GroupModel>();
          var usersModel = context.read<UsersModel>();
          var prefs = PrefService.of(context);

          var settings = _exportSettings
              ? prefs.toMap()
              : null;

          var subscriptions = _exportSubscriptions
              ? usersModel.subscriptions
              : null;

          var subscriptionGroups = _exportSubscriptionGroups
              ? groupModel.groups
              : null;

          var subscriptionGroupMembers = _exportSubscriptionGroupMembers
              ? await groupModel.listGroupMembers()
              : null;

          var tweets = _exportTweets
              ? await homeModel.listSavedTweets()
              : null;

          var data = SettingsData(
              settings: settings,
              subscriptions: subscriptions,
              subscriptionGroups: subscriptionGroups,
              subscriptionGroupMembers: subscriptionGroupMembers,
              tweets: tweets
          );

          var exportData = jsonEncode(data.toJson());

          var isLegacy = await isLegacyAndroid();
          if (isLegacy) {
            // This platform is too old to support a directory picker, so we just save the file to a predefined location
            var fullPath = await getLegacyPath(legacyExportFileName);

            await Directory(path.dirname(fullPath)).create(recursive: true);
            await File(fullPath).writeAsString(exportData);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Data exported to $fullPath'),
            ));
          } else {
            var dateFormat = DateFormat('yyyy-MM-dd');
            var fileName = 'fritter-${dateFormat.format(DateTime.now())}.json';

            // This platform can support the directory picker, so display it
            var fileInfo = await FilePickerWritable().openFileForCreate(fileName: fileName, writer: (file) async {
              file.writeAsStringSync(exportData);
            });
            if (fileInfo != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Data exported to $fileName'),
              ));
            }
          }
        },
      ),
      body: FutureBuilderWrapper<bool>(
        future: isLegacyAndroid(),
        onError: (error, stackTrace) => FullPageErrorWidget(error: error, stackTrace: stackTrace, prefix: 'Unable to check if this is a legacy Android device.'),
        onReady: (isLegacy) {
          Widget legacyAndroidMessage = Container();

          // Check if the platform is too old to support a directory picker or not
          if (isLegacy) {
            legacyAndroidMessage = FutureBuilderWrapper<String>(
              future: getLegacyPath(legacyExportFileName),
              onError: (error, stackTrace) => InlineErrorWidget(error: error),
              onReady: (legacyExportPath) {
                return Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text('Your device is running a version of Android older than KitKat (4.4), so the export can only be saved to:',
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
              Expanded(child: SingleChildScrollView(child: Column(
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
                ],
              ))),

              legacyAndroidMessage,
            ],
          );
        },
      ),
    );
  }
}
